# /food
resource "aws_api_gateway_resource" "FoodResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  //  parent_id   = "${aws_api_gateway_resource.RootResource.id}"
  parent_id   = "${aws_api_gateway_rest_api.APIDemo.root_resource_id}"
  path_part   = "food"
}

# /food/{id}
resource "aws_api_gateway_resource" "FoodIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "{id}"
}

# GET /food/{id}
module "FoodGetByIdMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD                   = "GET"
  URI                           = "${var.PROXY_URI}"
  REQUEST_PARAMS                = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING        = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}

# PUT /food/{id}
module "FoodPutByIdMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD                   = "PUT"
  URI                           = "${var.PROXY_URI}"
  REQUEST_PARAMS                = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING        = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}

# DELETE /food/{id}
module "FoodDeleteByIdMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodIdResource.id}"
  HTTP_METHOD                   = "DELETE"
  URI                           = "${var.PROXY_URI}"
  REQUEST_PARAMS                = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING        = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}

# POST /food
module "FoodCreateMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodResource.id}"
  HTTP_METHOD                   = "POST"
  URI                           = "${var.PROXY_URI}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}

# /food/allForCustomer
resource "aws_api_gateway_resource" "FoodAllForCustomerResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "allForCustomer"
}

# /food/allForCustomer/{id}
resource "aws_api_gateway_resource" "FoodAllForCustomerByIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodAllForCustomerResource.id}"
  path_part   = "{id}"
}

# GET /food/allForCustomer
module "FoodGetAllForCustomerByIdMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodAllForCustomerByIdResource.id}"
  HTTP_METHOD                   = "GET"
  URI                           = "${var.PROXY_URI}"
  REQUEST_PARAMS                = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING        = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}

# /food/buy
resource "aws_api_gateway_resource" "FoodBuyResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodResource.id}"
  path_part   = "buy"
}

# /food/buy/{id}
resource "aws_api_gateway_resource" "FoodBuyIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id   = "${aws_api_gateway_resource.FoodBuyResource.id}"
  path_part   = "{id}"
}

# POST /food/buy/{id}
module "FoodPostBuyIdMethod" {
  source                        = "./BasicHttpMethod"

  REST_API_ID                   = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID                   = "${aws_api_gateway_resource.FoodBuyIdResource.id}"
  HTTP_METHOD                   = "POST"
  URI                           = "${var.PROXY_URI}"
  REQUEST_PARAMS                = "${var.PATH_ID_PARAM["REQUIRED"]}"
  REQUEST_PARAMS_MAPPING        = "${var.PATH_ID_PARAM["INTEGRATION_MAPPING"]}"
  LAMBDA_VPC_EXECUTION_ROLE_ARN = "${var.LAMBDA_VPC_EXECUTION_ROLE_ARN}"
  EMPTY_MODEL_NAME              = "${aws_api_gateway_model.EmptyModel.name}"
}
