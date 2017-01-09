resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "ecd-watchdog-schedule"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "schedule" {
  rule      = "${aws_cloudwatch_event_rule.schedule.name}"
  target_id = "SendToLambda"
  arn       = "${aws_lambda_function.watchdog.arn}"
}

resource "aws_lambda_permission" "schedule" {
  statement_id  = "ecd-watchdog-schedule"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.watchdog.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.schedule.arn}"
}
