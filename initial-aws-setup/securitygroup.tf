resource "aws_security_group" "web-app-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "web-app-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.magento.cidr_block]
      self        = true
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.magento.cidr_block]
    self        = true
  }
  tags = {
    Name = "web-app-sg"
  }
}

resource "aws_security_group" "alb-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "alb-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [aws_security_group.web-app-sg.id]
    }
  }
  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group" "magento-mysql-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "magento-mysql-sg"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web-app-sg.id, ]
    cidr_blocks     = [aws_vpc.magento.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  tags = {
    Name = "magento-mysql-sg"
  }
}

resource "aws_security_group" "es-sg" {
  name   = "es-sg"
  vpc_id = aws_vpc.magento.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      aws_vpc.magento.cidr_block,
    ]
  }
}

resource "aws_security_group" "ec-sg" {
  name   = "ec-sg"
  vpc_id = aws_vpc.magento.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"
    cidr_blocks = [
      aws_vpc.magento.cidr_block,
    ]
  }
}

resource "aws_security_group" "jumpserver-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "jumpserver-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.DEVELOPER_ADDR]
    self        = true
  }

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [aws_security_group.web-app-sg.id]
    }
  }

  tags = {
    Name = "jumpserver-sg"
  }
}