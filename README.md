# AWS API Gateway Demo - WIP

## Infrastructure
The AWS infrastructure is being built with [Terraform](https://www.terraform.io/) 0.7.0-rc3.
All Terraform configs are located in the `Infrastructure` directory. Currently config brings up a security group, 
EC2 instances and a mock API Gateway definition.
### Bringing up the environment
To bring up the environment you need to have Terraform installed, and AWS access/secret keys defined in 
`~/.aws/credentials` [file](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html). 

You can define which region you want to use, and what images on which region should be deployed in the `variables.tf` file.

Build the microservices as described in the first two steps of the [Getting started](#getting-started) section.

(Optional) Set the environment variables containing a username and password of your choice. 
If you skip this step, terraform will prompt you for username and password. Username "admin" is reserved by AWS.

    export TF_VAR_DB_USERNAME=user
    export TF_VAR_DB_PASSWORD=pass

(Skip this step if you already have the `microservices.pem` file in the ~/.ssh/ directory)
To generate a key pair go to the AWS EC2 console > NETWORK & SECURITY > Key Pairs [(link for the eu-west-1 region)](https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#KeyPairs:sort=keyName)
and create a Key Pair named "microservices". Put the `microservices.pem` in the ~/.ssh/ directory. Then modify the permissions and add the key to the authentication agent.

    chmod 600 ~/.ssh/microservices.pem
    ssh-add -K ~/.ssh/microservices.pem

Create the AWS infrastructure by running `TerraformInfrastructure.sh`:

    chmod +x TerraformInfrastructure.sh
    ./TerraformInfrastructure.sh
 
Connect with the instances via SSH.

    ssh ec2-user@$(terraform output -state=./Infrastructure/terraform.tfstate ip_food_msvc)
    ssh ec2-user@$(terraform output -state=./Infrastructure/terraform.tfstate ip_customer_msvc)
    
Add `-d` or `--destroy` argument if you want to destroy the AWS infrastructure.

    ./TerraformInfrastructure.sh --destroy

### EC2
Two EC2 instances are created one for each microservice. Defined by `food-microservice.tf` and `customer-microservice.tf`.
Java is upgraded to version 1.8.0 on each instance and .jar files containing respective microservices are provisioned from the local machine.
`RunMicroservice.sh` is provisioned and launched as a cron job on the EC2 instance to ensure that the microservice is running.
Microservice's output is written to `~/microservice.log`.

### RDS
Microservices connect to a PostgreSQL database created before the EC2 instances.

### API Gateway
Currently API Gateway is brought up only to reflect current endpoints in the backend API. 
At this moment it is used to pass the input into the corresponding endpoint without modifying any data and responding with 200 response which contains
either data from successful endpoint execution or error code and message when the backend API fails. Base config is located
in `ApiGateBaseConfig.tf` and resources corresponding to each microservice are defined in `ApiGateFoodApi.tf` and `ApiGateCustomerApi.tf`.
After the API is defined by the above, it needs to be deployed. This is done in `ApiGateDeployment.tf` file. 
All variables required by this module are defined in `variables.tf`. Individual endpoints are created by supplying 4 components attached to
appropriate path. 

In terraform the path is defined with `path_part` property in a set of `aws_api_gateway_resource` components. 

    # /api/customer
    resource "aws_api_gateway_resource" "CustomerResource" {
      rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
      parent_id = "${aws_api_gateway_resource.RootResource.id}"
      path_part = "customer"
    }
    
    # /api/customer/{id}
    resource "aws_api_gateway_resource" "CustomerIdResource" {
      rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
      parent_id = "${aws_api_gateway_resource.CustomerResource.id}"
      path_part = "{id}"
    }

In this configuration the 4 components required to create an endpoint are defined in `BasicHttpMethod` sub-module. 
`BasicHttpMethod` can be instantiated to create a basic definition of a HTTP endpoint:

    # GET /api/customer/{id}
    module "CustomerGetByIdMethod" {
      source = "./BasicHttpMethod"
      
      REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
      RESOURCE_ID = "${aws_api_gateway_resource.CustomerIdResource.id}"
      HTTP_METHOD = "GET"
      URI = "${var.CUST_MS_BASE_URL}/customer/{id}"
      REQUEST_PARAMS = "${var.PATH_ID_PARAM.REQUIRED}"
      REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM.INTEGRATION_MAPPING}"
    }

#### BasicHttpMethod sub-module
This is a helper module that defines a basic HTTP API Gateway method. This is done by creating `aws_api_gateway_method`,
`aws_api_gateway_integration`, `aws_api_gateway_method_response` and `aws_api_gateway_integration_response`.

`aws_api_gateway_method` is used to define which method will be used by the caller, what authorization strategies will be used
and what parameters will be passed in.

    resource "aws_api_gateway_method" "Method" {
      rest_api_id = "${var.REST_API_ID}"
      resource_id = "${var.RESOURCE_ID}"
      http_method = "${var.HTTP_METHOD}"
      authorization = "NONE"
      request_parameters_in_json = "${var.REQUEST_PARAMS}"
    }
    
`aws_api_gateway_integration` defines where is the backend endpoint that API Gateway should be calling and what method will be used to integrate.

    resource "aws_api_gateway_integration" "Integration" {
      rest_api_id = "${var.REST_API_ID}"
      resource_id = "${var.RESOURCE_ID}"
      http_method = "${var.HTTP_METHOD}"
      integration_http_method = "${var.HTTP_METHOD}"
      type = "HTTP"
      uri = "${var.URI}"
      request_parameters_in_json = "${var.REQUEST_PARAMS_MAPPING}"
      depends_on = ["aws_api_gateway_method.Method"]
    }

`aws_api_gateway_integration_response` is used to define which responses from the backend are mapped to which responses to the client.

    resource "aws_api_gateway_integration_response" "IntegrationResponse" {
      rest_api_id = "${var.REST_API_ID}"
      resource_id = "${var.RESOURCE_ID}"
      http_method = "${var.HTTP_METHOD}"
      selection_pattern = "\\d{3}"
      status_code = "200"
      depends_on = ["aws_api_gateway_method_response.200Response"]
    }

`aws_api_gateway_method_response` is used to define possible responses selected in `aws_api_gateway_integration_response`

    resource "aws_api_gateway_method_response" "200Response" {
      rest_api_id = "${var.REST_API_ID}"
      resource_id = "${var.RESOURCE_ID}"
      http_method = "${var.HTTP_METHOD}"
      status_code = "200"
      depends_on = ["aws_api_gateway_integration.Integration"]
    }

Additionally `integration_resp_id` is returned. This can be used to make other resources dependant on this module 
by using this variable while defining them (for example api gateway deployment)

    # Used to detect that the method is fully created
    output "integration_resp_id" {
      value = "${aws_api_gateway_integration_response.IntegrationResponse.id}"
    }

## Microservices
### Getting started

Build the microservices with maven using `build.sh`:
    
    chmod +x build.sh
    ./build.sh
    
Provide the required environment variables.
    
    export DWDEMO_USER=dbuser
    export DWDEMO_PASSWORD=dbpass
    export DWDEMO_DB=jdbc:postgresql://localhost/microservices

Optionally you can provide env variables to change the ports on which the services are run.

    export FOOD_SVC_APP_PORT=8080
    export FOOD_SVC_ADMIN_PORT=8081
    export CUST_SVC_APP_PORT=8082
    export CUST_SVC_ADMIN_PORT=8083
    
Run the microservices locally. Point the `RunMicroservice.sh` script to the .jar files built by maven.

    chmod +x ./Infrastructure/RunMicroservice.sh
    ./Infrastructure/RunMicroservice.sh $FOODSVC_PATH/target/food-root-1.0-SNAPSHOT.jar $FOODSVC_PATH/config.yml
    ./Infrastructure/RunMicroservice.sh $CUSTOMERSVC_PATH/target/customer-root-1.0-SNAPSHOT.jar $CUSTOMERSVC_PATH/config.yml
    
`RunMicroservice.sh` won't produce any output if a given .jar file is already running.

## Food Service
Default port: 8080
### Supported methods
* POST    /food
* POST    /food/buy/{id}
* GET     /food/{id}
* GET     /food/allForCustomer/{customerId}
* PUT     /food/{id}
* DELETE  /food/{id}

## Customer Service
Default port: 8082
### Supported methods
* POST    /customer
* GET     /customer/{id}
* PUT     /customer/{id}
* DELETE  /customer/{id}
