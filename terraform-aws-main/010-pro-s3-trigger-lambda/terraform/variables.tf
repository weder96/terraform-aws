variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile to run Terraform with"
  type        = string
  default     = "tf015"
}
