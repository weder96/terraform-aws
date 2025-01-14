terraform {
  required_version = "1.10.4"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
     klayers = {
      version = "~> 1.0.0"
      source  = "ldcorentin/klayer"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


data "klayers_package_latest_version" "pandas" {
  name   = "pandas"
  region = "us-east-1"
}
