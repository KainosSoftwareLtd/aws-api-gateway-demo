resource "aws_iam_policy_attachment" "LambdaCloudWatchLogs" {
  name = "LambdaCloudWatchLogs"
  roles = ["${aws_iam_role.allow_lambda.name}"]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_policy_attachment" "LambdaVpcAccessExecution" {
  name = "LambdaVpcAccessExecution"
  roles = ["${aws_iam_role.allow_lambda.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

# TODO: find/create a more specific policy with less permissions
resource "aws_iam_policy_attachment" "LambdaFullAccess" {
  name = "LambdaFullAccess"
  roles = ["${aws_iam_role.allow_lambda.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}
