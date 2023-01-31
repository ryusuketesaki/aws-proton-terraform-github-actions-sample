/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
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

