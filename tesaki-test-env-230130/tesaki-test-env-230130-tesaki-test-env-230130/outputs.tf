/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
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