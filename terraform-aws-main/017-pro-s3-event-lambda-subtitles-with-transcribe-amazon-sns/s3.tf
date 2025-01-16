################################################################################
# S3 Source Image Bucket
################################################################################
resource "aws_s3_bucket" "source-bucket" {
  bucket = var.source_bucket_name
  force_destroy = true

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-source-bucket"
  })
}

################################################################################
# S3 target Image Bucket
################################################################################
resource "aws_s3_bucket" "target-bucket" {
  bucket = var.target_bucket_name
  force_destroy = true

  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-target-bucket"
  })
}

################################################################################
# Creating S3 Notification for Lambda when Object is uploaded in the Source Bucket
################################################################################
resource "aws_s3_bucket_notification" "transcribe_notification" {
  bucket = aws_s3_bucket.source-bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.create_transcript_lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [
    aws_lambda_permission.transcript_allow_bucket
  ]
}


resource "aws_s3_bucket_public_access_block" "transcribe_source" {
  bucket = aws_s3_bucket.source-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_public_access_block" "transcribe_target" {
  bucket = aws_s3_bucket.target-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
