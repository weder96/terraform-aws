################################################################################
# Compressing lambda_handler function code
################################################################################
data "archive_file" "thumbnail_lambda_source_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_function.zip"
}

################################################################################
# Creating Lambda Function
################################################################################
resource "aws_lambda_function" "create_thumbnail_lambda_function" {
  function_name = "CreateThumbnailLambdaFunction"
  filename      = "${path.module}/lambda_function.zip"

  runtime     = "python3.12"
  handler     = "thumbnail_generator.lambda_handler"
  memory_size = 256
  timeout     = 300

  environment {
    variables = {
      DEST_BUCKET = aws_s3_bucket.thumbnail-image-bucket.bucket
    }
  }

  source_code_hash = data.archive_file.thumbnail_lambda_source_archive.output_base64sha256

  role = aws_iam_role.lambda_s3_role.arn

  layers = [
    data.klayers_package_latest_version.pandas.arn
  ]
}

################################################################################
# Lambda Function Permission to have S3 as a Trigger for Lambda Function
################################################################################
resource "aws_lambda_permission" "thumbnail_allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_thumbnail_lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source-image-bucket.arn
}
