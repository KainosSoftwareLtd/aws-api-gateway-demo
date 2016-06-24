# AWS API Gateway Demo
## Microservices
### Getting started
* Create an empty PostgreSQL localhost database called 'microservices-demo'
* Add required environment variables.

Enviroment variables with default values:

	export DWDEMO_USER=username 
    export DWDEMO_PASSWORD=secret
    export DWDEMO_DBURL=jdbc:postgresql://localhost/microservices-demo
    export DWDEMO_HIBERDIALECT=org.hibernate.dialect.PostgreSQLDialect

## Food Service
### Supported methods
* POST    /food
* GET     /food?id={id}
* PUT     /food/{id}
* DELETE /food/{id}

## Cart Service
...
##TODO
* add cart service 
