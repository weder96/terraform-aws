################################################################################
# S3 Policy to Get and Put objects
################################################################################
resource "aws_iam_policy" "lambda_s3_policy" {
  name = "LambdaS3Policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Action" : "s3:GetObject",
      "Resource" : "${aws_s3_bucket.source-image-bucket.arn}/*"
      }, {
      "Effect" : "Allow",
      "Action" : "s3:PutObject",
      "Resource" : "${aws_s3_bucket.thumbnail-image-bucket.arn}/*"
    }]
  })
}

################################################################################
# Lambda IAM role to assume the role
################################################################################
resource "aws_iam_role" "lambda_s3_role" {
  name = "LambdaS3Role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

################################################################################
# Assign policy to the role
################################################################################
resource "aws_iam_policy_attachment" "assigning_policy_to_role" {
  name       = "AssigingPolicyToRole"
  roles      = [aws_iam_role.lambda_s3_role.name]
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}

resource "aws_iam_policy_attachment" "assigning_lambda_execution_role" {
  name       = "AssigningLambdaExecutionRole"
  roles      = [aws_iam_role.lambda_s3_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
