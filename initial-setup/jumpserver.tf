resource "aws_instance" "jump-server" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = var.JUMPSERVER_INSTANCE_TYPE
  tags = {
    Name = "jump-server"
  }

  subnet_id = aws_subnet.magento-public-1.id


  vpc_security_group_ids = [aws_security_group.jumpserver-sg.id]

  key_name = aws_key_pair.magento-key.key_name

  user_data = data.template_cloudinit_config.jumpserver-cloudinit.rendered

  depends_on = [aws_db_instance.magento]
}
