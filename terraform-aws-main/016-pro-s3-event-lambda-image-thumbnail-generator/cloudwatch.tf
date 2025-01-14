################################################################################
# Creating CloudWatch Log group for Lambda Function
################################################################################
resource "aws_cloudwatch_log_group" "create_thumbnail_lambda_function_cloudwatch" {
  name              = "/aws/lambda/${aws_lambda_function.create_thumbnail_lambda_function.function_name}"
  retention_in_days = 30
}
