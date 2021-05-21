resource "aws_lb" "admin_lb" {
  name               = var.alb
  load_balancer_type = "application"
  internal           = false
  subnets            = aws_default_subnet.default_azs.*.id
  security_groups    = [aws_security_group.admin_alb_sg.id]
}

resource "aws_lb_target_group" "admin_lb_target_grp" {
  name        = var.target-grp
  port        = var.app_port
  protocol    = "HTTP"
  target_type = var.lb_target_type
  vpc_id      = aws_default_vpc.default.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_lb_listener" "admin_lb_listener" {
  load_balancer_arn = aws_lb.admin_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.admin.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.admin_lb_target_grp.arn
  }
}