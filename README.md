# Terraform for ECD

We use this module to provision our AWS ECD deployments tools.

# General advise
We always provide (sane) defaults so that the components can be provisioned with little effort. Nevertheless they
can be configured through enough variables to make them more suitable.

# Submodules

## ECD
Read about it [here](/trademachines/ecd).

### Variables
* ``s3_prefix``: Provide a prefix to make the generated AWS S3 bucket globally unique.
* ``kms_key_admins``: Provide IAM users that will be admins to the generated AWS KMS key.
* ``lambda_policies``: Provide IAM policies that will be connected to the AWS Lambda function. It defaults to some coarse-grained AWS policies.

### Output
As the module only takes care about setting up the minimal necessary resources and does not involve in things like
monitoring, you need to reuse the following output variables if you want to do more than what is provided here.

* ``lambda_arn``
* ``lambda_iam_role_arn``
* ``s3_arn``

## Watchdog
Read about it [here](/trademachines/ecd-watchdog).

### Variables
* ``dynamodb_throughput``: Define the throughput for the DynamoDB table. It defaults to 1 for every index that is created.
* ``lambda_policies``: Provide IAM policies that will be connected to the AWS Lambda function. It defaults to some coarse-grained AWS policies.

### Output
As the module only takes care about setting up the minimal necessary resources and does not involve in things like
monitoring, you need to reuse the following output variables if you want to do more than what is provided here.

* ``lambda_arn``
* ``dynamodb_arn``
* ``lambda_iam_role_arn``
* ``cloudwatch_event_arn``
* ``cloudwatch_schedule_arn``
