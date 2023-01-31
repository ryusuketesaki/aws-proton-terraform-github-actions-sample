/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "PipelineEndpoint" {
  value = "https://${local.region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.pipeline.id}/view?region=${local.region}"
}
