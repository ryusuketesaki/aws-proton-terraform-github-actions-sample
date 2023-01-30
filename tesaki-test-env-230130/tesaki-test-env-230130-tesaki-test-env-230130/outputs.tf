/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:808225968452:service/tesaki-test-env-230130/service-instance/tesaki-test-env-230130

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "ServiceSqsDeadLetterQueueName" {
  value = aws_sqs_queue.ecs_processing_dlq.name
}

output "ServiceSqsDeadLetterQueueArn" {
  value = aws_sqs_queue.ecs_processing_dlq.arn
}

output "ServiceSqsQueueName" {
  value = aws_sqs_queue.ecs_processing_queue.name
}

output "ServiceSqsQueueArn" {
  value = aws_sqs_queue.ecs_processing_queue.arn
}