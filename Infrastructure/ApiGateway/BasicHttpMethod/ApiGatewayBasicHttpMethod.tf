resource "aws_api_gateway_method" "Method" {
  rest_api_id                = "${var.REST_API_ID}"
  resource_id                = "${var.RESOURCE_ID}"
  http_method                = "${var.HTTP_METHOD}"
  authorization              = "NONE"
  request_parameters_in_json = "${var.REQUEST_PARAMS}"
}

resource "aws_api_gateway_integration" "Integration" {
  rest_api_id                = "${var.REST_API_ID}"
  resource_id                = "${var.RESOURCE_ID}"
  http_method                = "${var.HTTP_METHOD}"
  //  integration_http_method = "POST" # Lambda function can only be invoked with POST?
  integration_http_method    = "${var.HTTP_METHOD}"
  type                       = "AWS"
  uri                        = "${var.URI}"
  passthrough_behavior       = "WHEN_NO_TEMPLATES"
  request_parameters_in_json = "${var.REQUEST_PARAMS_MAPPING}"
  request_templates          = {
    "application/json" = "${file("${path.module}/api_gateway_body_mapping.template")}"
  }
  credentials                = "arn:aws:iam::410667175105:role/iam_for_lambda"
  depends_on                 = ["aws_api_gateway_method.Method"]
}

resource "aws_api_gateway_method_response" "200Response" {
  rest_api_id                 = "${var.REST_API_ID}"
  resource_id                 = "${var.RESOURCE_ID}"
  http_method                 = "${var.HTTP_METHOD}"
  status_code                 = "200"
  response_parameters_in_json = "{
      \"method.response.header.content-length\": true
    }"
  response_models             = {
    "application/json" = "${var.EMPTY_MODEL_NAME}"
  }
  depends_on                  = ["aws_api_gateway_integration.Integration"]
}

resource "aws_api_gateway_integration_response" "IntegrationResponse" {
  rest_api_id        = "${var.REST_API_ID}"
  resource_id        = "${var.RESOURCE_ID}"
  http_method        = "${var.HTTP_METHOD}"
  //  selection_pattern = "\\d{3}"
  status_code        = "200"
  depends_on         = ["aws_api_gateway_method_response.200Response"]
  response_templates = {
    "application/json" = "${file("${path.module}/integration_response_200.template")}"
  }
  response_parameters_in_json = "{
      \"method.response.header.content-length\": \"integration.response.header.content-length\"
    }"
}

# Used to detect that the method is fully created
output "integration_resp_id" {
  value = "${aws_api_gateway_integration_response.IntegrationResponse.id}"
}