# AWS API Gateway Demo - WIP

## Infrastructure
The AWS infrastructure is being built with [Terraform](https://www.terraform.io/). 
All Terraform configs are located in the `Infrastructure` directory. Currently config brings up a security group, 
EC2 instances and a mock API Gateway definition.
### Bringing up the environment
To bring up the environment you need to have Terraform installed, and AWS access/secret keys defined in 
`~/.aws/credentials` [file](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html). 
You can run the process by executing `terraform apply` from the `Infrastructure` directory. 
In order to destroy the environment you can invoke `terraform destroy`.

You can define which region you want to use, and what images on which region should be deployed in the `variables.tf` file.

### EC2
Two EC2 instances are created one for each microservice. Defined by `food-microservice.tf` and `customer-microservice.tf`.

### API Gateway
Currently API Gateway is brought up only to reflect current endpoints in the backend API. 
It is not integrated with the microservices yet though - that is work in progress. The API Gateway base path is defined 
in `ApiGateBaseConfig.tf` and resources corresponding to each microservice are defined in `ApiGateFoodApi.tf` and `ApiGateCustomerApi.tf`.

## Microservices
### Getting started
* Create an empty PostgreSQL localhost database called "microservices-demo"
* Add required environment variables.

Environment variables with default values:

	export DWDEMO_USER=username 
    export DWDEMO_PASSWORD=secret

* Package each microservice (run all commands from repository's root directory)

<!-- this separates the code snippet from the list element above -->
    FOODSVC_PATH="./Microservices/FoodService"
    mvn -f $FOODSVC_PATH/pom.xml package

    CUSTOMERSVC_PATH="./Microservices/CustomerService"
    mvn -f $CUSTOMERSVC_PATH/pom.xml package

* Run jars

<!-- this separates the code snippet from the list element above -->
    java -jar $FOODSVC_PATH/target/food-root-1.0-SNAPSHOT.jar server $FOODSVC_PATH/config.yml
    java -jar $CUSTOMERSVC_PATH/target/customer-root-1.0-SNAPSHOT.jar server $CUSTOMERSVC_PATH/config.yml 
    
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
