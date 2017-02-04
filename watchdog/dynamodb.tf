resource "aws_dynamodb_table" "watchdog" {
  name           = "ecd-watchdog"
  read_capacity  = "${var.dynamodb_throughput}"
  write_capacity = "${var.dynamodb_throughput}"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "deployment"
    type = "S"
  }

  attribute {
    name = "previous_deployment"
    type = "S"
  }

  attribute {
    name = "state"
    type = "S"
  }

  attribute {
    name = "last_updated_at"
    type = "N"
  }

  global_secondary_index {
    name            = "Deployment"
    hash_key        = "deployment"
    write_capacity  = "${var.dynamodb_throughput}"
    read_capacity   = "${var.dynamodb_throughput}"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "PreviousDeployment"
    hash_key        = "previous_deployment"
    write_capacity  = "${var.dynamodb_throughput}"
    read_capacity   = "${var.dynamodb_throughput}"
    projection_type = "ALL"
  }

  global_secondary_index {
    name            = "State"
    hash_key        = "state"
    range_key       = "last_updated_at"
    write_capacity  = "${var.dynamodb_throughput}"
    read_capacity   = "${var.dynamodb_throughput}"
    projection_type = "ALL"
  }
}
