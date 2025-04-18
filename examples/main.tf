terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "name" {
  description = "Nme of the S3 bucket"
  type        = string
}

module "s3_bucket" {
  source              = "../"
  name                = var.name
  versioning_enabled  = true
  force_destroy       = true
  tags = {
    Project = "S3-Module"
    Env   = "test"
  }
}
