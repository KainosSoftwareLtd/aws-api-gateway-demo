export TF_VAR_FOODSVC_PATH="./Microservices/FoodService"
export TF_VAR_CUSTOMERSVC_PATH="./Microservices/CustomerService"

terraform get ./Infrastructure

case "$1" in
    -d|--destroy)
	echo "Destroying existing resources."
	terraform destroy -state=./Infrastructure/terraform.tfstate ./Infrastructure
	exit 0
    ;;
esac

terraform apply -state=./Infrastructure/terraform.tfstate ./Infrastructure
