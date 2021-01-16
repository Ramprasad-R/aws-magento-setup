module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = "magento-alb"

  load_balancer_type = "application"

  vpc_id          = aws_vpc.magento.id
  subnets         = [aws_subnet.magento-public-1.id, aws_subnet.magento-public-2.id, aws_subnet.magento-public-3.id]
  security_groups = [aws_security_group.alb-sg.id]


  target_groups = [
    {
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = var.DOMAIN_CERT_ARN
      target_group_index = 0
      action_type        = "forward"
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    Name = "magento-alb"
  }
}