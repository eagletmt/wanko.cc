resource "aws_s3_bucket" "wanko-cc" {
  bucket = "wanko-cc"
}

resource "aws_s3_bucket_website_configuration" "wanko-cc" {
  bucket = aws_s3_bucket.wanko-cc.bucket
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "wanko-cc" {
  bucket = aws_s3_bucket.wanko-cc.bucket
  policy = data.aws_iam_policy_document.wanko-cc.json
}

data "aws_iam_policy_document" "wanko-cc" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
    ]
    resources = [
      aws_s3_bucket.wanko-cc.arn,
      "${aws_s3_bucket.wanko-cc.arn}/*",
    ]
  }
}

resource "aws_acm_certificate" "wanko-cc" {
  provider          = aws.use1
  domain_name       = "wanko.cc"
  validation_method = "DNS"
}

data "aws_route53_zone" "wanko-cc" {
  name         = "wanko.cc."
  private_zone = false
}

resource "aws_route53_record" "wanko-cc-validation" {
  for_each = {
    for dvo in aws_acm_certificate.wanko-cc.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.aws_route53_zone.wanko-cc.id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "wanko-cc" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.wanko-cc.arn
  validation_record_fqdns = [for record in aws_route53_record.wanko-cc-validation : record.fqdn]
}

locals {
  s3_origin_id = "s3-origin"
}

resource "aws_cloudfront_distribution" "wanko-cc" {
  origin {
    domain_name = aws_s3_bucket.wanko-cc.website_endpoint
    origin_id   = local.s3_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 0
  }
  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 0
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = [aws_acm_certificate.wanko-cc.domain_name]
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.wanko-cc.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_route53_record" "wanko-cc" {
  for_each = toset(["A", "AAAA"])

  zone_id = data.aws_route53_zone.wanko-cc.id
  name    = "wanko.cc"
  type    = each.value
  alias {
    name                   = aws_cloudfront_distribution.wanko-cc.domain_name
    zone_id                = aws_cloudfront_distribution.wanko-cc.hosted_zone_id
    evaluate_target_health = false
  }
}
