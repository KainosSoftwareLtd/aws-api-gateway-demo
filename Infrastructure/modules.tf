module "RDS" {
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  source = "./RDS"
  security_group_id = "${aws_security_group.allow_all.id}"
}

module "FOOD_EC2" {
  source = "./EC2"
  MSVC_NAME = "Food"
  MSVC_PATH = "${var.FOODSVC_PATH}"
  JAR_FILE = "food-root-1.0-SNAPSHOT.jar"
  security_group_id = "${aws_security_group.allow_all.id}"
  db_endpoint = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  SVC_VAR_NAME = "FOOD_SVC"
  APP_PORT = "${var.FOOD_SVC_APP_PORT}"
  ADMIN_PORT = "${var.FOOD_SVC_ADMIN_PORT}"
  CUST_SVC_URL = "http://${module.CUSTOMER_EC2.ip_msvc}:${var.CUST_SVC_APP_PORT}"
  region = "${var.region}"
}
output "ip_food_msvc" {
  value = "${module.FOOD_EC2.ip_msvc}"
}

module "CUSTOMER_EC2" {
  source = "./EC2"
  MSVC_NAME = "Customer"
  MSVC_PATH = "${var.CUSTOMERSVC_PATH}"
  JAR_FILE = "customer-root-1.0-SNAPSHOT.jar"
  security_group_id = "${aws_security_group.allow_all.id}"
  db_endpoint = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  SVC_VAR_NAME = "CUST_SVC"
  APP_PORT = "${var.CUST_SVC_APP_PORT}"
  ADMIN_PORT = "${var.CUST_SVC_ADMIN_PORT}"
  CUST_SVC_URL = "http://localhost:${var.CUST_SVC_APP_PORT}"
  region = "${var.region}"
}
output "ip_customer_msvc" {
  value = "${module.CUSTOMER_EC2.ip_msvc}"
}

module "ApiGateway" {
  source = "./ApiGateway"
  CUST_MS_BASE_URL = "http://${module.CUSTOMER_EC2.ip_msvc}:${var.CUST_SVC_APP_PORT}"
  FOOD_MS_BASE_URL = "http://${module.FOOD_EC2.ip_msvc}:${var.FOOD_SVC_APP_PORT}"
}
