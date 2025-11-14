terraform {
  required_version = "1.10.4"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "Serverless REST API knowledge base"
      CreatedAt = "2025-11-14"
      ManagedBy = "Terraform"
      Owner     = "SousaW96"
      Env       = var.env
    }
  }
}
