# https://developer.hashicorp.com/terraform/language/import
# https://developer.hashicorp.com/terraform/language/import/generating-configuration

terraform {
  required_version = "~> 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.19"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      "Video"     = "Terraform Import"
      "CreatedAt" = "2025-01-11"
      "ManagedBy" = "Terraform"
    }
  }
}
