resource "aws_iam_role" "allow_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_lambda_function" "proxy" {
  filename = "${path.root}/proxy.zip" # s3_bucket can be used instead
  function_name = "VpcProxy"
  role = "${aws_iam_role.allow_lambda.arn}"
  handler = "ProxyApiGatewayToBackend.myHandler"
  source_code_hash = "${base64sha256(file("${path.root}/proxy.zip"))}"
}

output "proxy_arn" {
  value = "${aws_lambda_function.proxy.arn}"
}
