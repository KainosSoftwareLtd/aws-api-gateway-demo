export FOODSVC_PATH="./Microservices/FoodService"
export CUSTOMERSVC_PATH="./Microservices/CustomerService"

mvn -f $FOODSVC_PATH/pom.xml package
mvn -f $CUSTOMERSVC_PATH/pom.xml package