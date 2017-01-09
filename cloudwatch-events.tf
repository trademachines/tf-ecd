resource "aws_cloudwatch_event_rule" "events" {
  name = "ecd-watchdog-events"

  event_pattern = <<PATTERN
      {
        "source": [
          "tm.ecdc",
          "aws.ecs"
        ],
        "detail-type": [
          "ECDC Service Deployment Started",
          "ECS Task State Change"
        ]
      }
PATTERN
}

resource "aws_cloudwatch_event_target" "events" {
  rule      = "${aws_cloudwatch_event_rule.events.name}"
  target_id = "SendToLambda"
  arn       = "${aws_lambda_function.watchdog.arn}"
}

resource "aws_lambda_permission" "events" {
  statement_id  = "ecd-watchdog-events"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.watchdog.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.events.arn}"
}
