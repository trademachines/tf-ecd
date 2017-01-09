variable "dynamodb_throughput" {
  default = 1
}

variable "lambda_policies" {
  type = "list"

  default = [
    "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess",
    "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerServiceFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
  ]
}

output "cloudwatch_event_arn" {
  value = "${aws_cloudwatch_event_rule.events.arn}"
}

output "cloudwatch_schedule_arn" {
  value = "${aws_cloudwatch_event_rule.schedule.arn}"
}

output "lambda_iam_role_arn" {
  value = "${aws_iam_role.watchdog.arn}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.watchdog.arn}"
}

output "dynamodb_arn" {
  value = "${aws_dynamodb_table.watchdog.arn}"
}
