variable "FOODSVC_PATH" {}
variable "CUSTOMERSVC_PATH" {}
variable "DB_USERNAME" {}
variable "DB_PASSWORD" {}

variable "FOOD_JAR" {
	default = "food-root-1.0-SNAPSHOT.jar"
}
variable "CUSTOMER_JAR" {
	default = "customer-root-1.0-SNAPSHOT.jar"
}

variable "region" {
	default = "eu-west-1"
}

variable "amis" {
	default = {
        eu-west-1 = "ami-f9dd458a" 	# Amazon Linux AMI HVM EBS-Backed 64 bit
        eu-central-1 = "ami-26e70c49"	# Ubuntu 16.04 LTS amd64 hvm:ebs-ssd
    }
}