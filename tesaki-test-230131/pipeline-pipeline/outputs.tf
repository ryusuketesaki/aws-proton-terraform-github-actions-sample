/*
This file is managed by AWS Proton. Any changes made directly to this file will be overwritten the next time AWS Proton performs an update.

To manage this resource, see AWS Proton Resource: arn:aws:proton:ap-northeast-1:808225968452:service/pipeline/service-instance/pipeline

If the resource is no longer accessible within AWS Proton, it may have been deleted and may require manual cleanup.
*/

output "ServiceUrl" {
  value = "https://${aws_lb.service_lb.dns_name}"
}
