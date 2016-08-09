module "RDS" {
  DB_PASSWORD          = "${var.DB_PASSWORD}"
  DB_USERNAME          = "${var.DB_USERNAME}"
  source               = "./RDS"
  main_vpc_id          = "${aws_vpc.vpc_main.id}"
  db_subnet_group_name = "${aws_db_subnet_group.microservices.name}"
  security_group_ids   = ["${aws_security_group.allow_postgres.id}", "${aws_security_group.allow_microservices.id}"]
}

module "FOOD_EC2" {
  source             = "./EC2"
  MSVC_NAME          = "Food"
  MSVC_PATH          = "${var.FOODSVC_PATH}"
  JAR_FILE           = "food-root-1.0-SNAPSHOT.jar"
  db_endpoint        = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD        = "${var.DB_PASSWORD}"
  DB_USERNAME        = "${var.DB_USERNAME}"
  SVC_VAR_NAME       = "FOOD_SVC"
  APP_PORT           = "${var.FOOD_SVC_APP_PORT}"
  ADMIN_PORT         = "${var.FOOD_SVC_ADMIN_PORT}"
  AWS_REGION         = "${var.AWS_REGION}"
  subnet_id          = "${aws_subnet.zone_a.id}"
  security_group_ids = [
    "${aws_security_group.allow_http_https.id}",
    "${aws_security_group.allow_microservices.id}",
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_postgres.id}",
    "${aws_security_group.allow_dns_udp.id}"]
}

output "ip_food_msvc" {
  value = "${module.FOOD_EC2.ip_msvc}"
}

module "CUSTOMER_EC2" {
  source             = "./EC2"
  MSVC_NAME          = "Customer"
  MSVC_PATH          = "${var.CUSTOMERSVC_PATH}"
  JAR_FILE           = "customer-root-1.0-SNAPSHOT.jar"
  db_endpoint        = "${module.RDS.microservices_db_endpoint}"
  DB_PASSWORD        = "${var.DB_PASSWORD}"
  DB_USERNAME        = "${var.DB_USERNAME}"
  AWS_REGION         = "${var.AWS_REGION}"
  subnet_id          = "${aws_subnet.zone_a.id}"
  SVC_VAR_NAME       = "CUST_SVC"
  APP_PORT           = "${var.CUST_SVC_APP_PORT}"
  ADMIN_PORT         = "${var.CUST_SVC_ADMIN_PORT}"
  security_group_ids = [
    "${aws_security_group.allow_http_https.id}",
    "${aws_security_group.allow_microservices.id}",
    "${aws_security_group.allow_ssh.id}",
    "${aws_security_group.allow_postgres.id}",
    "${aws_security_group.allow_dns_udp.id}"]
}

output "ip_customer_msvc" {
  value = "${module.CUSTOMER_EC2.ip_msvc}"
}

module "IAM" {
  source = "./IAM"
}

module "Lambda" {
  source = "./Lambda"
  vpc_id = "${aws_vpc.vpc_main.id}"
  subnet_ids = ["${aws_subnet.zone_a.id}", "${aws_subnet.zone_b.id}"]
  security_group_ids = ["${aws_security_group.allow_microservices.id}"]
  allow_lambda_arn = "${module.IAM.allow_lambda_arn}"
}

module "ApiGateway" {
  source           = "./ApiGateway"
  CUST_MS_BASE_URL = "https://${module.CUSTOMER_EC2.ip_msvc}:${var.CUST_SVC_APP_PORT}"
  FOOD_MS_BASE_URL = "https://${module.FOOD_EC2.ip_msvc}:${var.FOOD_SVC_APP_PORT}"
  PROXY_URI        = "arn:aws:apigateway:${var.AWS_REGION}:lambda:path/2015-03-31/functions/${module.Lambda.proxy_arn}/invocations"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${module.IAM.allow_lambda_arn}"
}

