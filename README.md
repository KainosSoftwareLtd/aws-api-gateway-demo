# AWS API Gateway Demo
## Microservices
### Getting started
* Create an empty PostgreSQL localhost database called "microservices-demo"
* Add required environment variables.

Environment variables with default values:

	export DWDEMO_USER=username 
    export DWDEMO_PASSWORD=secret

* Provide arguments needed to run a program 

<!-- this separates the code snippet from the list element above -->
	
	server config.yml

## Food Service
### Supported methods
* POST    /food
* GET     /food/{id}
* GET     /food/allForCustomer/{customerId}
* PUT     /food/{id}
* DELETE  /food/{id}

## Customer Service
### Supported methods
* POST    /customer
* GET     /customer/{id}
* PUT     /customer/{id}
* DELETE  /customer/{id}
