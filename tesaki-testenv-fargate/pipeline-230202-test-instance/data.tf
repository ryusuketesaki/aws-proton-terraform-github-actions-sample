/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:808225968452:service/pipeline/service-instance/230202-test-instance

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "ecs_task_execution_role_policy_document" {
  statement {
    actions   = ["sns:Publish"]
    resources = [var.environment.outputs.SnsTopicArn]
  }
}

data "aws_iam_policy_document" "task_role_permission_boundary_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject",
      "sqs:Get*",
      "sqs:List*",
      "sqs:Send*"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "base_task_role_managed_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}