variable "MSVC_PATH" {
}
variable "JAR_FILE" {
}
variable "MSVC_NAME" {
}
variable "DB_USERNAME" {
}
variable "DB_PASSWORD" {
}
variable "security_group_ids" {
  type = "list"
}
variable "db_endpoint" {
}
variable "AWS_REGION" {
}
variable "subnet_id" {
}
variable "APP_PORT" {
}
variable "ADMIN_PORT" {
}
variable "SVC_VAR_NAME" {
}
variable "amis" {
  default = {
    eu-west-1    = "ami-f9dd458a"    # Amazon Linux AMI HVM EBS-Backed 64 bit
    eu-central-1 = "ami-ea26ce85"    # Amazon Linux AMI HVM EBS-Backed 64 bit
  }
}
