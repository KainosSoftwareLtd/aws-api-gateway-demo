export TF_VAR_FOODSVC_PATH="./Microservices/FoodService"
export TF_VAR_CUSTOMERSVC_PATH="./Microservices/CustomerService"

case "$1" in
    -d|--destroy)
	echo "Destroying existing resources."
	terraform destroy -state=./Infrastructure/terraform.tfstate ./Infrastructure
	exit 1
    ;;
esac

terraform apply -state=./Infrastructure/terraform.tfstate ./Infrastructure