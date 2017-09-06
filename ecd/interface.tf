variable "s3_bucket_name" {}
variable "kms_key_admins" {
  type = "list"
  default = []
}

variable "lambda_policies" {
  type = "list"

  default = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
  ]
}

output "lambda_iam_role_arn" {
  value = "${aws_iam_role.ecd.arn}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.ecd.arn}"
}

output "s3_arn" {
  value = "${aws_s3_bucket.ecd_configs.arn}"
}
