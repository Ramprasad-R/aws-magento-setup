resource "aws_launch_configuration" "magento-launchconfig" {
  name_prefix     = "magento-launchconfig-"
  image_id        = var.MAGENTO_INSTANCE_AMI
  instance_type   = "t3a.medium"
  key_name        = var.ssh_key_name
  security_groups = [var.magento_ec2_sg]
  iam_instance_profile = var.magento_instance_role
  lifecycle {
    create_before_destroy = true
  }
  root_block_device {
      volume_size = "30"
      volume_type = "gp2"
    }
  }

resource "aws_autoscaling_group" "magento-autoscaling" {
  name                      = "magento-autoscaling"
  vpc_zone_identifier       = [var.private_subnet_1, var.private_subnet_2, var.private_subnet_3]
  launch_configuration      = aws_launch_configuration.magento-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  tag {
    key                 = "Name"
    value               = "Magento Ec2 instance"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "magento-asg-attachment" {
  autoscaling_group_name = aws_autoscaling_group.magento-autoscaling.id
  alb_target_group_arn   = var.target_group_arn
}