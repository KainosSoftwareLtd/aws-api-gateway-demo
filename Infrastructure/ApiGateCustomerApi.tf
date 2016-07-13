resource "aws_api_gateway_resource" "CustomerResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.RootResource.id}"
  path_part = "customer"
}

resource "aws_api_gateway_resource" "CustomerIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.CustomerResource.id}"
  path_part = "{id}"
}

# GET /api/customer/{id}
resource "aws_api_gateway_method" "CustomerGetByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "CustomerGetByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "${aws_api_gateway_method.CustomerGetByIdMethod.http_method}"
  type = "MOCK"
}

# PUT /api/customer/{id}
resource "aws_api_gateway_method" "CustomerPutByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "CustomerPutByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "${aws_api_gateway_method.CustomerPutByIdMethod.http_method}"
  type = "MOCK"
}

# DELETE /api/customer/{id}
resource "aws_api_gateway_method" "CustomerDeleteByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "CustomerDeleteByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerIdResource.id}"
  http_method = "${aws_api_gateway_method.CustomerDeleteByIdMethod.http_method}"
  type = "MOCK"
}

# POST /api/customer
resource "aws_api_gateway_method" "CustomerCreateMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerResource.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "CustomerCreateIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.CustomerResource.id}"
  http_method = "${aws_api_gateway_method.CustomerCreateMethod.http_method}"
  type = "MOCK"
}
