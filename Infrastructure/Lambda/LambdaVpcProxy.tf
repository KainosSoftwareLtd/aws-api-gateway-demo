resource "aws_lambda_function" "proxy" {
  filename = "${path.root}/proxy.zip" # s3_bucket can be used instead
  function_name = "VpcProxy"
  role = "${var.allow_lambda_arn}"
  handler = "ProxyApiGatewayToBackend.myHandler"
  source_code_hash = "${base64sha256(file("${path.root}/proxy.zip"))}"
  vpc_config {
//    vpc_id = "${var.vpc_id}"
    subnet_ids = ["${var.subnet_ids}"]
    security_group_ids = ["${var.security_group_ids}"]
  }
}

output "proxy_arn" {
  value = "${aws_lambda_function.proxy.arn}"
}
