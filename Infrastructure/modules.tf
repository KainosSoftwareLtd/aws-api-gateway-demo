module "ApiGateway" {
  source = "./ApiGateway"
}

module "RDS" {
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  source = "./RDS"
  security_group_id = "${aws_security_group.allow_microservices.id}"
  main_vpc_id = "${aws_vpc.vpc_main.id}"
  region = "${var.region}"
  db_subnet_group_name = "${aws_db_subnet_group.microservices.name}"
}

module "FOOD_EC2" {
  source = "./EC2"
  MSVC_NAME = "Food"
  MSVC_PATH = "${var.FOODSVC_PATH}"
  JAR_FILE = "food-root-1.0-SNAPSHOT.jar"
  security_group_id = "${aws_security_group.allow_microservices.id}"
  db_endpoint = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  region = "${var.region}"
  subnet_id = "${aws_subnet.zone_a.id}"
}

output "ip_food_msvc" {
  value = "${module.FOOD_EC2.ip_msvc}"
}

module "CUSTOMER_EC2" {
  source = "./EC2"
  MSVC_NAME = "Customer"
  MSVC_PATH = "${var.CUSTOMERSVC_PATH}"
  JAR_FILE = "customer-root-1.0-SNAPSHOT.jar"
  security_group_id = "${aws_security_group.allow_microservices.id}"
  db_endpoint = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD = "${var.DB_PASSWORD}"
  DB_USERNAME = "${var.DB_USERNAME}"
  region = "${var.region}"
  subnet_id = "${aws_subnet.zone_a.id}"
}

output "ip_customer_msvc" {
  value = "${module.CUSTOMER_EC2.ip_msvc}"
}
