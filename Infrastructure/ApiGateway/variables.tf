variable "CUST_MS_BASE_URL" {
}
variable "FOOD_MS_BASE_URL" {
}
variable "GATEWAY_CERT_ID" {
}

variable "PATH_ID_PARAM" {
  default = {

    REQUIRED =
      <<PARAMS
        {
          "method.request.path.id": true
        }
      PARAMS

    INTEGRATION_MAPPING =
      <<PARAMS
        {
            "integration.request.path.id": "method.request.path.id"
        }
      PARAMS
  }
}
