# AWS API Gateway Demo
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
