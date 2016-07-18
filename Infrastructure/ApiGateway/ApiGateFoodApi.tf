# /api/food
resource "aws_api_gateway_resource" "FoodResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.RootResource.id}"
  path_part = "food"
}

# /api/food/{id}
resource "aws_api_gateway_resource" "FoodIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.FoodResource.id}"
  path_part = "{id}"
}

# GET /api/food/{id}
resource "aws_api_gateway_method" "FoodGetByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodGetByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "${aws_api_gateway_method.FoodGetByIdMethod.http_method}"
  type = "MOCK"
}

# PUT /api/food/{id}
resource "aws_api_gateway_method" "FoodPutByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodPutByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "${aws_api_gateway_method.FoodPutByIdMethod.http_method}"
  type = "MOCK"
}

# DELETE /api/food/{id}
resource "aws_api_gateway_method" "FoodDeleteByIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodDeleteByIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodIdResource.id}"
  http_method = "${aws_api_gateway_method.FoodDeleteByIdMethod.http_method}"
  type = "MOCK"
}

# POST /api/food
resource "aws_api_gateway_method" "FoodCreateMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodResource.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodCreateIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodResource.id}"
  http_method = "${aws_api_gateway_method.FoodCreateMethod.http_method}"
  type = "MOCK"
}

# /api/food/allForCustomer
resource "aws_api_gateway_resource" "FoodAllForCustomerResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.FoodResource.id}"
  path_part = "allForCustomer"
}

# GET /api/food/allForCustomer
resource "aws_api_gateway_method" "FoodGetAllForCustomerMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodAllForCustomerResource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodGetAllForCustomerIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodAllForCustomerResource.id}"
  http_method = "${aws_api_gateway_method.FoodGetAllForCustomerMethod.http_method}"
  type = "MOCK"
}

# /api/food/buy
resource "aws_api_gateway_resource" "FoodBuyResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.FoodResource.id}"
  path_part = "buy"
}

# /api/food/buy/{id}
resource "aws_api_gateway_resource" "FoodBuyIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.FoodBuyResource.id}"
  path_part = "{id}"
}

# POST /api/food/buy/{id}
resource "aws_api_gateway_method" "FoodPostBuyIdMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodBuyIdResource.id}"
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "FoodPostBuyIdIntegration" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  resource_id = "${aws_api_gateway_resource.FoodBuyIdResource.id}"
  http_method = "${aws_api_gateway_method.FoodPostBuyIdMethod.http_method}"
  type = "MOCK"
}
