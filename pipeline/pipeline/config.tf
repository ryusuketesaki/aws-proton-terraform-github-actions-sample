/*
This file is no longer managed by AWS Proton. The associated resource has been deleted in Proton.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {}
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
  alias  = "default"

  default_tags {
    tags = {
      "proton:pipeline" = var.service.name
    }
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
