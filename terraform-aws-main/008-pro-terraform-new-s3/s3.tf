# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#example-usage
resource "aws_s3_bucket" "website" {
  bucket = random_pet.bucket_name.id
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.website.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "website" {
  bucket = aws_s3_bucket.website.id
  acl    = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.website.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"      
    ]

    resources = [
      "${aws_s3_bucket.website.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  content_type = "text/html; charset=UTF-8"
  source       = "website/index.html"
  etag         = filemd5("website/index.html")
}

resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  content_type = "text/html; charset=UTF-8"
  source       = "website/error.html"
  etag         = filemd5("website/error.html")
}
