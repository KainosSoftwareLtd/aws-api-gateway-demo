# /api/food
resource "aws_api_gateway_resource" "FoodResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.RootResource.id}"
  path_part   = "food"
}

# /api/food/{id}
resource "aws_api_gateway_resource" "FoodIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "{id}"
}

# GET /api/food/{id}
module "FoodGetByIdMethod" {
  source                 = "./BasicHttpMethod"

  REST_API_ID            = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID            = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD            = "GET"
  URI                    = "${var.PROXY_URI}"
  REQUEST_PARAMS         = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
}

# PUT /api/food/{id}
module "FoodPutByIdMethod" {
  source                 = "./BasicHttpMethod"

  REST_API_ID            = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID            = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD            = "PUT"
  URI                    = "${var.PROXY_URI}"
  REQUEST_PARAMS         = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
}

# DELETE /api/food/{id}
module "FoodDeleteByIdMethod" {
  source                 = "./BasicHttpMethod"

  REST_API_ID            = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID            = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD            = "DELETE"
  URI                    = "${var.PROXY_URI}"
  REQUEST_PARAMS         = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
}

# POST /api/food
module "FoodCreateMethod" {
  source      = "./BasicHttpMethod"

  REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID = "${aws_api_gateway_resource.FoodResource.id}"
  HTTP_METHOD = "POST"
  URI         = "${var.PROXY_URI}"
}

# /api/food/allForCustomer
resource "aws_api_gateway_resource" "FoodAllForCustomerResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "allForCustomer"
}

# /api/food/allForCustomer/{id}
resource "aws_api_gateway_resource" "FoodAllForCustomerByIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodAllForCustomerResource.id}"
  path_part   = "{id}"
}

# GET /api/food/allForCustomer
module "FoodGetAllForCustomerByIdMethod" {
  source                 = "./BasicHttpMethod"

  REST_API_ID            = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID            = "${aws_api_gateway_resource.FoodAllForCustomerByIdResource.id}"
  HTTP_METHOD            = "GET"
  URI                    = "${var.PROXY_URI}"
  REQUEST_PARAMS         = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
}

# /api/food/buy
resource "aws_api_gateway_resource" "FoodBuyResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "buy"
}

# /api/food/buy/{id}
resource "aws_api_gateway_resource" "FoodBuyIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodBuyResource.id}"
  path_part   = "{id}"
}

# POST /api/food/buy/{id}
module "FoodPostBuyIdMethod" {
  source                 = "./BasicHttpMethod"

  REST_API_ID            = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID            = "${aws_api_gateway_resource.FoodBuyIdResource.id}"
  HTTP_METHOD            = "POST"
  URI                    = "${var.PROXY_URI}"
  REQUEST_PARAMS         = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
}
