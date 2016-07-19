# /api/customer
resource "aws_api_gateway_resource" "CustomerResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.RootResource.id}"
  path_part = "customer"
}

# /api/customer/{id}
resource "aws_api_gateway_resource" "CustomerIdResource" {
  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  parent_id = "${aws_api_gateway_resource.CustomerResource.id}"
  path_part = "{id}"
}

# GET /api/customer/{id}
module "CustomerGetByIdMethod" {
  source = "./BasicHttpMethod"
  
  REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID = "${aws_api_gateway_resource.CustomerIdResource.id}"
  HTTP_METHOD = "GET"
  # TODO: parametrize ports, maybe pull path from parameters? Or maybe swagger to param mapping here? :> Would be awesome imo.
  URI = "http://${var.CUST_MS_PUB_IP}:8082/customer/{id}"
  REQUEST_PARAMS = "${var.PATH_ID_PARAM.REQUIRED}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM.INTEGRATION_MAPPING}"
}

# PUT /api/customer/{id}
module "CustomerPutByIdMethod" {
  source = "./BasicHttpMethod"

  REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID = "${aws_api_gateway_resource.CustomerIdResource.id}"
  HTTP_METHOD = "PUT"
  URI = "http://${var.CUST_MS_PUB_IP}:8082/customer/{id}"
  REQUEST_PARAMS = "${var.PATH_ID_PARAM.REQUIRED}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM.INTEGRATION_MAPPING}"
}

# DELETE /api/customer/{id}
module "CustomerDeleteByIdMethod" {
  source = "./BasicHttpMethod"
  
  REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID = "${aws_api_gateway_resource.CustomerIdResource.id}"
  HTTP_METHOD = "DELETE"
  URI = "http://${var.CUST_MS_PUB_IP}:8082/customer/{id}"
  REQUEST_PARAMS = "${var.PATH_ID_PARAM.REQUIRED}"
  REQUEST_PARAMS_MAPPING = "${var.PATH_ID_PARAM.INTEGRATION_MAPPING}"
}

# POST /api/customer
module "CustomerCreateMethod" {
  source = "./BasicHttpMethod"
  
  REST_API_ID = "${aws_api_gateway_rest_api.APIDemo.id}"
  RESOURCE_ID = "${aws_api_gateway_resource.CustomerResource.id}"
  HTTP_METHOD = "POST"
  URI = "http://${var.CUST_MS_PUB_IP}:8082/customer"
}