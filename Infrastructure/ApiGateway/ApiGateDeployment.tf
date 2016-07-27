resource "null_resource" "ApiReady" {
  triggers {
    # Explicitly wait for all methods. This is because module dependencies are not available in terraform
    api_ready = <<CONTENT
    {
      "CustomerPutByIdMethod": "${module.CustomerPutByIdMethod.integration_resp_id}",
      "CustomerDeleteByIdMethod": "${module.CustomerDeleteByIdMethod.integration_resp_id}",
      "CustomerGetByIdMethod": "${module.CustomerGetByIdMethod.integration_resp_id}",
      "CustomerCreateMethod": "${module.CustomerCreateMethod.integration_resp_id}",
      "FoodGetByIdMethod": "${module.FoodGetByIdMethod.integration_resp_id}",
      "FoodPutByIdMethod": "${module.FoodPutByIdMethod.integration_resp_id}",
      "FoodDeleteByIdMethod": "${module.FoodDeleteByIdMethod.integration_resp_id}",
      "FoodCreateMethod": "${module.FoodCreateMethod.integration_resp_id}",
      "FoodGetAllForCustomerByIdMethod": "${module.FoodGetAllForCustomerByIdMethod.integration_resp_id}",
      "FoodPostBuyIdMethod": "${module.FoodPostBuyIdMethod.integration_resp_id}"
    }
    CONTENT
  }
}

resource "aws_cloudformation_stack" "ApiGatewayDemoDeployment" {
  name = "ApiGatewayDemoDeployment"
  depends_on = ["null_resource.ApiReady"]
  template_body =
  <<STACK
    {
      "Resources": {
        "AlphaDeploy": {
          "Type": "AWS::ApiGateway::Deployment",
          "Properties": {
            "RestApiId": "${aws_api_gateway_rest_api.APIDemo.id}",
            "StageName": "dummy"
          }
        },
        "AlphaStage" : {
          "Type" : "AWS::ApiGateway::Stage",
          "Properties" :
          {
            "DeploymentId" : {"Ref": "AlphaDeploy"},
            "RestApiId": "${aws_api_gateway_rest_api.APIDemo.id}",
            "StageName" : "alpha",
            "ClientCertificateId" : "${var.GATEWAY_CERT_ID}"
          }
        }
      }
    }
  STACK
}
