FOODSVC_PATH="./Microservices/FoodService"
mvn -f $FOODSVC_PATH/pom.xml package

CUSTOMERSVC_PATH="./Microservices/CustomerService"
mvn -f $CUSTOMERSVC_PATH/pom.xml package