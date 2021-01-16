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

  tags = {
    Name = "magento-alb"
  }
}