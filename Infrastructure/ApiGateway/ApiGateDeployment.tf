resource "aws_api_gateway_deployment" "alpha" {
  # API needs to depend on resources, but dependiogn on modules not possible atm...

  rest_api_id = "${aws_api_gateway_rest_api.APIDemo.id}"
  stage_name = "alpha"
}