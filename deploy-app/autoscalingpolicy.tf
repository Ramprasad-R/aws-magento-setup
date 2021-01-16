resource "aws_autoscaling_policy" "magento-cpu-policy" {
  name                   = "magento-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.magento-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "magento-cpu-alarm" {
  alarm_name          = "magento-cpu-alarm"
  alarm_description   = "magento-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.magento-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.magento-cpu-policy.arn]
}

resource "aws_autoscaling_policy" "magento-cpu-policy-scaledown" {
  name                   = "magento-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.magento-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "magento-cpu-alarm-scaledown" {
  alarm_name          = "magento-cpu-alarm-scaledown"
  alarm_description   = "magento-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.magento-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.magento-cpu-policy-scaledown.arn]
}

