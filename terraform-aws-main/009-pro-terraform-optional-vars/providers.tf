provider "aws" {
  region  = "us-east-1"
  profile = "tf015"

  default_tags {
    tags = {
      Project     = "Terraform Module Object Attributes"
      ManagedBy   = "Terraform"
      CreatedAt   = "October 2022"
      Environment = "dev"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "random_pet" "bucket_name" {
  prefix = data.aws_caller_identity.current.account_id
  length = 2
}
