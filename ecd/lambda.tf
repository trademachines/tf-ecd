resource "aws_iam_role" "ecd" {
  name = "lambda-ecd"

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

resource "aws_iam_role_policy_attachment" "ecd" {
  count      = "${length(var.lambda_policies)}"
  role       = "${aws_iam_role.ecd.id}"
  policy_arn = "${element(var.lambda_policies, count.index)}"
}

resource "aws_lambda_function" "ecd" {
  role             = "${aws_iam_role.ecd.arn}"
  function_name    = "ecd"
  description      = "Deploys services to AWS ECD"
  handler          = "index.handle"
  runtime          = "nodejs6.10"
  timeout          = "10"
  vpc_config       = []
  filename         = "${path.module}/lambda-empty.zip"
  source_code_hash = ""

  environment {
    variables {
      BUCKET = "${var.s3_bucket_name}"
    }
  }

  lifecycle {
    ignore_changes = ["timeout", "handler", "description", "runtime"]
  }
}
