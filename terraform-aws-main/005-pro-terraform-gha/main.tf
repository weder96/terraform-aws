terraform {
  required_version = "1.10.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "Terraform GHA setup"
      CreatedAt = "2025-01-11"
      ManagedBy = "Terraform"
      Owner     = "SousaW96"
    }
  }
}
