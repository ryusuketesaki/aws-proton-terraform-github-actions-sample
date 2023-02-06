/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

variable "service_instances" {
  type = list(
    object({
      name    = string
      inputs  = any
      outputs = map(string)
      environment = object({
        account_id = string
        name       = string
        outputs    = map(string)
      })
    })
  )
}

variable "service" {
  type = object({
    name                      = string
    branch_name               = string
    repository_connection_arn = string
    repository_id             = string
  })
  default = null
}

variable "pipeline" {
  type = object({
    inputs = any
  })
  default = null
}

variable "proton_tags" {
  type    = map(string)
  default = null
}
