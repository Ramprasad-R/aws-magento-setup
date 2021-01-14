# resource "aws_route53_zone" "main-domain" {
#   name = "${var.MAIN_DOMAIN}"
# }

resource "aws_route53_record" "cdn-media-domain" {
  zone_id = var.DOMAIN_ZONE_ID # aws_route53_zone.main-domain.zone_id
  name    = var.CDN_MEDIA_DOMAIN
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.media.domain_name
    zone_id                = aws_cloudfront_distribution.media.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cdn-static-domain" {
  zone_id = var.DOMAIN_ZONE_ID ## aws_route53_zone.main-domain.zone_id
  name    = var.CDN_STATIC_DOMAIN
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.static.domain_name
    zone_id                = aws_cloudfront_distribution.static.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "webapp" {
  zone_id = var.DOMAIN_ZONE_ID ## aws_route53_zone.main-domain.zone_id
  name    = var.WEB_APP_DOMAIN
  type    = "A"

  alias {
    name                   = module.alb.this_lb_dns_name
    zone_id                = module.alb.this_lb_zone_id
    evaluate_target_health = false
  }
}

