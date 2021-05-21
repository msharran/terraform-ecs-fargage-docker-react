output "ecr_repo_uri" {
  value = var.app_image
}

output "loadbalancer_dns" {
  value = aws_lb.admin_lb.dns_name
}

output "admin_url" {
  value = aws_route53_record.admin.name
}