################################################################################
# S3 Source Image Bucket
################################################################################
resource "aws_s3_bucket" "source-image-bucket" {
  bucket = "${var.source_bucket_name}-${random_string.lower.result}"
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-source-bucket"
  })
}

################################################################################
# S3 Thumbnail Image Bucket
################################################################################
resource "aws_s3_bucket" "thumbnail-image-bucket" {
  bucket = "${var.thumbnail_bucket_name}-${random_string.lower.result}"
  tags = merge(local.common_tags, {
    Name = "${local.naming_prefix}-s3-thumbnail-bucket"
  })
}

################################################################################
# Creating S3 Notification for Lambda when Object is uploaded in the Source Bucket
################################################################################
resource "aws_s3_bucket_notification" "thumbnail_notification" {
  bucket = aws_s3_bucket.source-image-bucket.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.create_thumbnail_lambda_function.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [
    aws_lambda_permission.thumbnail_allow_bucket
  ]
}


resource "random_string" "lower" {
  length  = 4
  upper   = false
  lower   = true
  special = false
}

