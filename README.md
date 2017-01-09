# Terraform for ECD

We use this module to provision our AWS ECD deployments tools.

# Watchdog
Read about it [here](/trademachines/ecd-watchdog).

## Variables
We always provide (sane) defaults so that the component can be provisioned with less effort.

* ``dynamodb_throughput``: Define the throughput for the DynamoDB table. It defaults to 1 for every index that is created.
* ``lambda_policies``: Provide IAM policies that will be connected to the AWS Lambda function. It defaults to some coarse-grained AWS policies.

## Output
As the module only takes care about setting up the minimal necessary resources and does not involve in things like
monitoring, you need to reuse the following output variables if you want to do more than what is provided here.

* ``lambda_arn``
* ``dynamodb_arn``
* ``lambda_iam_role_arn``
* ``cloudwatch_event_arn``
* ``cloudwatch_schedule_arn``
