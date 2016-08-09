variable "REST_API_ID" {}
variable "RESOURCE_ID" {}
variable "HTTP_METHOD" {}
variable "URI" {}
variable "REQUEST_PARAMS" {
	default = ""
}
variable "REQUEST_PARAMS_MAPPING" {
	default = ""
}
variable "LAMBDA_VPC_EXECUTION_ROLE_ARN" {
	type = "string"
}
variable "EMPTY_MODEL_NAME" {
	type = "string"
	default = "EmptyModel"
}