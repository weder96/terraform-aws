resource "aws_s3_bucket" "lambda" {
  bucket = "${local.account_id}-${local.component_name}"
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.lambda.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "lambda" {
  bucket = aws_s3_bucket.lambda.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_object" "readme" {
  bucket       = aws_s3_bucket.lambda.id
  key          = "input/images/${local.readme_file}"
  content_type = "text/markdown; charset=UTF-8"
  source       = local.readme_file_path
  etag         = filemd5(local.readme_file_path)
}

resource "aws_s3_bucket_notification" "s3_trigger" {
  bucket = aws_s3_bucket.lambda.id

  lambda_function {
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "input/images"
    filter_suffix       = ".jpg"
    lambda_function_arn = aws_lambda_function.s3_trigger.arn
  }
}
