resource "aws_api_gateway_rest_api" "APIDemo" {
  name = "APIDemo"
  description = "Demo API Gateway deployment"
}

resource "aws_api_gateway_resource" "RootResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_rest_api.APIDemo.root_resource_id}"
  path_part = "api"
}

output "api_id" {
	value = "${aws_api_gateway_rest_api.APIDemo.id}"
}
