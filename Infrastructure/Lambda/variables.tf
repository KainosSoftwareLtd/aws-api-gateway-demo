variable "vpc_id" {
  type = "string"
}
variable "subnet_ids" {
  type = "list"
}
variable "security_group_ids" {
  type = "list"
}
variable "allow_lambda_arn" {
  type = "string"
}
