/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

output "ServiceUrl" {
  value = "https://${aws_lb.service_lb.dns_name}"
}