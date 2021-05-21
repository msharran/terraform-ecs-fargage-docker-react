data "aws_route53_zone" "app" {
  name = var.domain
}

resource "aws_route53_record" "admin" {
  zone_id = data.aws_route53_zone.app.zone_id
  name    = "${var.sub_domain}.${data.aws_route53_zone.app.name}"
  type    = "A"

  alias {
    name                   = aws_lb.admin_lb.dns_name
    zone_id                = aws_lb.admin_lb.zone_id
    evaluate_target_health = false
  }
}

data "aws_acm_certificate" "admin" {
  domain      = aws_route53_record.admin.name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}