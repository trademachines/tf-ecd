resource "aws_iam_role" "watchdog" {
  name = "lambda-ecd-watchdog"

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

resource "aws_iam_role_policy_attachment" "watchdog" {
  count      = "${length(var.lambda_policies)}"
  role       = "${aws_iam_role.watchdog.id}"
  policy_arn = "${element(var.lambda_policies, count.index)}"
}

resource "aws_lambda_function" "watchdog" {
  role             = "${aws_iam_role.watchdog.arn}"
  function_name    = "ecd-watchdog"
  description      = "Manages state information of ECD deployments"
  handler          = "index.handle"
  runtime          = "nodejs4.3"
  timeout          = "10"
  vpc_config       = []
  filename         = "${path.module}/lambda-empty.zip"
  source_code_hash = ""

  lifecycle {
    ignore_changes = ["timeout", "handler", "description"]
  }
}
