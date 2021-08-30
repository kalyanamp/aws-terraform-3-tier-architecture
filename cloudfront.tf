resource "aws_cloudfront_distribution" "wordpress" {
  enabled     = true
  price_class = "PriceClass_200"

  origin {
    domain_name = aws_lb.external-elb1.dns_name
    origin_id   = "alb"

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = ["TLSv1.2"]
      origin_keepalive_timeout = 60
      origin_read_timeout      = 30
    }
  }

  default_cache_behavior {
    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]

    cached_methods = ["GET", "HEAD", "OPTIONS"]

    target_origin_id = "alb"
    compress         = true

    forwarded_values {
      headers = ["*"]

      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 0
    min_ttl     = 0
    max_ttl     = 0
  }

  ordered_cache_behavior {
    path_pattern = "wp-includes/*"

    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]

    cached_methods = ["GET", "HEAD", "OPTIONS"]

    target_origin_id = "alb"
    compress         = true

    forwarded_values {
      headers      = ["Host"]
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 86400
    min_ttl     = 0
    max_ttl     = 604800
  }

  ordered_cache_behavior {
    path_pattern = "wp-content/*"

    allowed_methods = [
      "DELETE",
      "GET",
      "HEAD",
      "OPTIONS",
      "PATCH",
      "POST",
      "PUT",
    ]

    cached_methods = ["GET", "HEAD", "OPTIONS"]

    target_origin_id = "alb"
    compress         = true

    forwarded_values {
      headers      = ["Host"]
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"

    default_ttl = 86400
    min_ttl     = 0
    max_ttl     = 604800
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = "${var.tags}"
}