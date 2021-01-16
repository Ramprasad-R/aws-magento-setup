resource "aws_s3_bucket" "media-bucket" {
  bucket = var.S3_MEDIA_BUCKET
  versioning {
    enabled = true
  }
  tags = {
    Name = "media-bucket"
  }
  force_destroy = true
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "HEAD", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "media-bucket" {
  bucket = aws_s3_bucket.media-bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1610493767808",
    "Statement": [
        {
            "Sid": "Stmt1610493757016",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.media-bucket.arn}/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "static-bucket" {
  bucket = var.S3_STATIC_BUCKET
  versioning {
    enabled = true
  }
  tags = {
    Name = "static-bucket"
  }
  force_destroy = true
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET", "HEAD", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_policy" "static-bucket" {
  bucket = aws_s3_bucket.static-bucket.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1610493767808",
    "Statement": [
        {
            "Sid": "Stmt1610493757016",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.static-bucket.arn}/*"
        }
    ]
}
POLICY
}