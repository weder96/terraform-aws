terraform {
  required_version = "~> 1.10.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "tf015"

  default_tags {
    tags = {
      Project     = "Terraform new S3 Bucket"
      ManagedBy   = "Terraform"
      CreatedAt   = "January 2025"
      Environment = "dev"
    }
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
data "aws_caller_identity" "current" {}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "bucket_name" {
  prefix = data.aws_caller_identity.current.account_id
  length = 4
}
