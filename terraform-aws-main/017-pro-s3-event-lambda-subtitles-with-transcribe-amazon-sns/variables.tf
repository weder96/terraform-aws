variable "aws_region" {
  type        = string
  description = "AWS region to use for resources."
  default     = "us-east-1"
}

variable "source_bucket_name" {
  type        = string
  description = "Name of the S3 Bucket"
  default     = "my-s3-source-sousaw96-bucket-v1"
}

variable "target_bucket_name" {
  type        = string
  description = "Name of the S3 Bucket"
  default     = "my-s3-target-sousaw96-bucket-v1"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "CT"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
  default     = "Project"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources."
  default     = "Demo"
}

variable "environment" {
  type        = string
  description = "Environment for deployment"
  default     = "dev"
}

variable "instance_key" {
  default = "WorkshopKeyPair"
}

variable "email_address" {
  type        = list(string)
  description = "List of email addresses to receive email alert"
  default     = ["weder96@gmail.com"]
}

variable "aws_account_id" {
  type    = string
  default = "710304818543"
}

variable "aws_profile" {
  type    = string
  default = "tf015"
}
