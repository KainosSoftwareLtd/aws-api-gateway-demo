resource "aws_api_gateway_rest_api" "APIDemo" {
  name = "APIDemo"
  description = "Demo API Gateway deployment"
}

resource "aws_api_gateway_model" "EmptyModel" {
  rest_api_id  = "${aws_api_gateway_rest_api.APIDemo.id}"
  name         = "EmptyModel"
  description  = "a JSON schema"
  content_type = "application/json"
  schema       = <<EOF
  {"type": "object"}
  EOF
}

output "api_id" {
	value = "${aws_api_gateway_rest_api.APIDemo.id}"
}
