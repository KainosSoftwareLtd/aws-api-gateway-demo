CURRENT_DIR=`dirname $0`
CERTIFICATE_VAR_NAME="GATEWAY_CERT_ID"

# Check whether certificate id has already been assigned to a terraform variable.
if grep -q "$CERTIFICATE_VAR_NAME" "$CURRENT_DIR/terraform.tfvars"; then
    echo "Skipping certificate generation. $CERTIFICATE_VAR_NAME already exists in $CURRENT_DIR/terraform.tfvars."
    exit 0
fi

# Generate a client certificate and store its ID in the .tfvars file.

CERT_ID=$(aws apigateway generate-client-certificate --query 'clientCertificateId')
echo "GATEWAY_CERT_ID = \"$CERT_ID\"" > ${CURRENT_DIR}/terraform.tfvars
echo "A new client certificate has been generated and its ID has been saved to a variable '$CERTIFICATE_VAR_NAME' in $CURRENT_DIR/terraform.tfvars"

# Generate a new private server key
openssl genrsa -out server.key 2048
# Create a new certificate signing request
openssl req -new -subj '/CN=localhost' -out server.csr -key server.key
# Sign a request
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
# Create a PKCS12 file
openssl pkcs12 -export -in server.crt -inkey server.key -out server.p12 -name awsMicroservice -CAfile server.crt -caname root -password pass:12341234

# Create a JKS keystore
keytool -deststorepass 12341234 -srcstorepass 12341234 -importkeystore -destkeystore keystore.jks -srckeystore server.p12 -srcstoretype pkcs12 -alias awsMicroservice

# Get the public client certificate from the API Gateway
aws apigateway get-client-certificate --client-certificate-id "$CERT_ID" --query 'pemEncodedCertificate' > aws.crt
# Add the server and API Gateway certificates to a trust store
keytool -deststorepass 12341234 -import -file aws.crt -alias awsCA -keystore awsTrustStore.jks -noprompt
keytool -deststorepass 12341234 -import -file server.crt -alias serverCA -keystore awsTrustStore.jks -noprompt
