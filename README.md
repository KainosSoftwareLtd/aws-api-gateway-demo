# AWS API Gateway Demo
## Microservices
### Getting started
* Create an empty PostgreSQL localhost database called "microservices-demo"
* Add required environment variables.

Environment variables with default values:

	export DWDEMO_USER=username 
    export DWDEMO_PASSWORD=secret
    export DWDEMO_DBURL=jdbc:postgresql://localhost/microservices-demo
    export DWDEMO_HIBERDIALECT=org.hibernate.dialect.PostgreSQLDialect

* Provide arguments needed to run a program 

<!-- this separates the code snippet from the list element above -->
	
	server config.yml

## Food Service
### Supported methods
* POST    localhost:8080/food
<<<<<<< HEAD
* GET     localhost:8080/food/{id}
=======
* GET     localhost:8080/food?id={id}
>>>>>>> 717cd23b92ac08e1b0e37fc838001bb4922e4493
* GET     localhost:8080/food/allForCustomer/{customerId}
* PUT     localhost:8080/food/{id}
* DELETE  localhost:8080/food/{id}

## Customer Service
### Supported methods
* POST    localhost:8082/customer
* GET     localhost:8082/customer/{id}
* PUT     localhost:8082/customer/{id}
* DELETE  localhost:8082/customer/{id}

## TODO
<<<<<<< HEAD
* Add more tests
=======
* Add tests
>>>>>>> 717cd23b92ac08e1b0e37fc838001bb4922e4493
