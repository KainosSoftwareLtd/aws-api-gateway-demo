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
Java is upgraded to version 1.8.0 on each instance and .jar files containing respective microservices are provisioned from the local machine.

### RDS
Microservices connect to a PostgreSQL database created before EC2 instances. 

### API Gateway
Currently API Gateway is brought up only to reflect current endpoints in the backend API. 
It is not integrated with the microservices yet though - that is work in progress. The API Gateway base path is defined 
in `ApiGateBaseConfig.tf` and resources corresponding to each microservice are defined in `ApiGateFoodApi.tf` and `ApiGateCustomerApi.tf`.

## Microservices
### Getting started

Build microservices with maven using `build.sh`:
    
    chmod +x build.sh
    ./build.sh

(Optional) Set the environment variables containing a username and password of your choice. 
If you skip this step, terraform will prompt you for username and password.
Username "admin" is reserved by AWS.

    export TF_VAR_DB_USERNAME=user
    export TF_VAR_DB_PASSWORD=pass

Create the AWS infrastructure by running `start.sh`:

    chmod +x start.sh
    ./start.sh
    
Add `-d` or `--destroy` argument to destroy the infrastructure.

    ./start.sh --destroy
    
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
