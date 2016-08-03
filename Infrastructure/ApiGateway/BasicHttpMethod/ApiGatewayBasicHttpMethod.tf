resource "aws_api_gateway_method" "Method" {
  rest_api_id = "${var.REST_API_ID}"
  resource_id = "${var.RESOURCE_ID}"
  http_method = "${var.HTTP_METHOD}"
  authorization = "NONE"
  request_parameters_in_json = "${var.REQUEST_PARAMS}"
}

//resource "aws_api_gateway_integration" "Integration" {
//  rest_api_id = "${var.REST_API_ID}"
//  resource_id = "${var.RESOURCE_ID}"
//  http_method = "${var.HTTP_METHOD}"
//  integration_http_method = "${var.HTTP_METHOD}"
//  type = "HTTP"
//  uri = "${var.URI}"
//  request_parameters_in_json = "${var.REQUEST_PARAMS_MAPPING}"
//  depends_on = ["aws_api_gateway_method.Method"]
//}

resource "aws_api_gateway_integration" "Integration" {
  rest_api_id = "${var.REST_API_ID}"
  resource_id = "${var.RESOURCE_ID}"
  http_method = "${var.HTTP_METHOD}"
  integration_http_method = "POST" # Lambda function can only be invoked with POST
  type = "AWS"
  uri = "${var.URI}"
//  request_parameters_in_json = "${var.REQUEST_PARAMS_MAPPING}"
  request_templates = {
    "application/json" = "${file("${path.module}/api_gateway_body_mapping.template")}"
  }
  depends_on = ["aws_api_gateway_method.Method"]
}

resource "aws_api_gateway_method_response" "200Response" {
  rest_api_id = "${var.REST_API_ID}"
  resource_id = "${var.RESOURCE_ID}"
  http_method = "${var.HTTP_METHOD}"
  status_code = "200"
  depends_on = ["aws_api_gateway_integration.Integration"]
}

resource "aws_api_gateway_integration_response" "IntegrationResponse" {
  rest_api_id = "${var.REST_API_ID}"
  resource_id = "${var.RESOURCE_ID}"
  http_method = "${var.HTTP_METHOD}"
  selection_pattern = "\\d{3}"
  status_code = "200"
  depends_on = ["aws_api_gateway_method_response.200Response"]
}

# Used to detect that the method is fully created
output "integration_resp_id" {
  value = "${aws_api_gateway_integration_response.IntegrationResponse.id}"
}