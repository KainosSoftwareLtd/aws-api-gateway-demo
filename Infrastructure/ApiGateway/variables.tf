variable "CUST_MS_PUB_IP" {}
variable "FOOD_MS_PUB_IP" {}

variable "PATH_ID_PARAM" {
	default = {
		REQUIRED = <<PARAMS
	 	{
	    	"method.request.path.id": true
	  	}
		PARAMS
		INTEGRATION_MAPPING = <<PARAMS
	  	{	
	    	"integration.request.path.id": "method.request.path.id"
	  	}
		PARAMS
	}
}