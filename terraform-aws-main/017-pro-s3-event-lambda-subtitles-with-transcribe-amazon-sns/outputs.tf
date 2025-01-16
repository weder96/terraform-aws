output "services_created" {
  description = "Services Created"
  value       = "Services Created"
}

output "topic_arn" {
  description = "ARN of SNS topic"
  value       = aws_sns_topic.topic.arn
}

output "s3_source" {
  description = "ARN of S3 Source"
  value       = aws_s3_bucket.source-bucket.arn
}


output "s3_target" {
  description = "ARN of S3 Target"
  value       = aws_s3_bucket.target-bucket.arn
}