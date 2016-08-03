export TF_VAR_FOODSVC_PATH="./Microservices/FoodService"
export TF_VAR_CUSTOMERSVC_PATH="./Microservices/CustomerService"

# -update will not delay this command too much as long as our modules are not accessed remotely
terraform get -update ./Infrastructure

case "$1" in
    -d|--destroy)
	echo "Destroying existing resources."
	terraform destroy -state=./Infrastructure/terraform.tfstate ./Infrastructure
	exit 0
    ;;
esac

zip  --junk-paths --filesync ./Infrastructure/proxy.zip ./Infrastructure/Lambda/ProxyApiGatewayToBackend.js
terraform apply -state=./Infrastructure/terraform.tfstate -var-file=./Infrastructure/ApiGateway/terraform.tfvars ./Infrastructure
