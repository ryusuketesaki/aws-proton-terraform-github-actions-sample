/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

locals {
  account_id           = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.id
  partition            = data.aws_partition.current.id
  partition_url_suffix = data.aws_partition.current.dns_suffix
}