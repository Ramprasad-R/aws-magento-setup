resource "aws_cloudfront_distribution" "media" {
  origin {
    domain_name = aws_s3_bucket.media-bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.media-bucket.id}"
  }

  enabled         = true
  is_ipv6_enabled = true

  aliases = [var.CDN_FQDN_MEDIA_ALIAS]

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.media-bucket.id}"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.CDN_ACM_CERT_ARN
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}

resource "aws_cloudfront_distribution" "static" {
  origin {
    domain_name = aws_s3_bucket.static-bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.static-bucket.id}"
  }

  enabled         = true
  is_ipv6_enabled = true

  aliases = [var.CDN_FQDN_STATIC_ALIAS]

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${aws_s3_bucket.static-bucket.id}"
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    compress               = true
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.CDN_ACM_CERT_ARN
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}