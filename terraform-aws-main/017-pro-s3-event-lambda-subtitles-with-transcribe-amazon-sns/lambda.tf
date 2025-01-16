################################################################################
# Compressing lambda_handler function code
################################################################################
data "archive_file" "transcript_lambda_source_archive" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_function.zip"
}

################################################################################
# Creating Lambda Function
################################################################################
resource "aws_lambda_function" "create_transcript_lambda_function" {
  function_name = "transcribeVideoLambdaFunction"
  filename      = "${path.module}/lambda_function.zip"

  runtime     = "python3.12"
  handler     = "transcribe_generator.lambda_handler"
  memory_size = 256
  timeout     = 300

  source_code_hash = data.archive_file.transcript_lambda_source_archive.output_base64sha256
  role = aws_iam_role.lambda_s3_role.arn
}

################################################################################
# Lambda Function Permission to have S3 as a Trigger for Lambda Function
################################################################################
resource "aws_lambda_permission" "transcript_allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.create_transcript_lambda_function.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.source-bucket.arn
}
