resource "aws_db_subnet_group" "mysql-subnet" {
  name        = "mysql-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.magento-private-1.id, aws_subnet.magento-private-2.id, aws_subnet.magento-private-3.id]
}

resource "aws_db_instance" "magento" {
  allocated_storage       = 100
  engine                  = "mysql"
  engine_version          = "8.0.20"
  instance_class          = var.RDS_INSTANCE_CLASS
  identifier              = "magento"
  name                    = "magento"
  username                = var.RDS_USERNAME
  password                = var.RDS_PASSWORD
  db_subnet_group_name    = aws_db_subnet_group.mysql-subnet.name
  parameter_group_name    = "default.mysql8.0"
  multi_az                = "false"
  vpc_security_group_ids  = [aws_security_group.magento-mysql-sg.id]
  storage_type            = "gp2"
  backup_retention_period = 30
  availability_zone       = aws_subnet.magento-private-1.availability_zone
  skip_final_snapshot     = true
  tags = {
    Name = "magento-rds-instance"
  }
}

