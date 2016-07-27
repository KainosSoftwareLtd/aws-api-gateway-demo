CURRENT_DIR=`dirname $0`
CERTIFICATE_VAR_NAME="GATEWAY_CERT_ID"

# Check whether certificate id has already been assigned to a terraform variable.
if grep -q "$CERTIFICATE_VAR_NAME" "$CURRENT_DIR/terraform.tfvars"; then
    echo "Skipping certificate generation. $CERTIFICATE_VAR_NAME already exists in $CURRENT_DIR/terraform.tfvars."
    exit 0
fi

# Generate a client certificate and store its ID in the .tfvars file.
echo "GATEWAY_CERT_ID = \"$(aws apigateway generate-client-certificate --query 'clientCertificateId')\"" > ${CURRENT_DIR}/terraform.tfvars
echo "A new client certificate has been generated and its ID has been saved to a variable '$CERTIFICATE_VAR_NAME' in $CURRENT_DIR/terraform.tfvars"

# TODO: things below might be useful in the next commit
#aws apigateway get-client-certificate --client-certificate-id $(head -n 1 cert-id) > cert.txt
#rm cert-id
