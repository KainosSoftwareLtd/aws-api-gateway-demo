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
  region = "${var.region}"
}
output "ip_customer_msvc" {
  value = "${module.CUSTOMER_EC2.ip_msvc}"
}

module "ApiGateway" {
  source = "./ApiGateway"
  CUST_MS_PUB_IP = "${module.CUSTOMER_EC2.ip_msvc}"
  FOOD_MS_PUB_IP = "${module.FOOD_EC2.ip_msvc}"
}
