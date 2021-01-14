resource "aws_security_group" "web-app-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "web-app-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-app-sg"
  }
}

resource "aws_security_group" "magento-mysql-sg" {
  vpc_id = aws_vpc.magento.id
  name   = "magento-mysql-sg"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web-app-sg.id]
    cidr_blocks     = [var.DEVELOPER_ADDR] # Remove for production instance
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

