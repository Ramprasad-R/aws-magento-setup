data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "magento-es" {
  domain_name           = "magento-es"
  elasticsearch_version = "7.9"

  cluster_config {
    instance_type = var.ES_INSTANCE_TYPE
  }

  vpc_options {
    subnet_ids = [aws_subnet.magento-private-1.id]

    security_group_ids = [aws_security_group.es-sg.id]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  ebs_options {
    volume_type = "gp2"
    volume_size = 10
    ebs_enabled = true
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/magento-es/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = {
    Domain = "magento-es"
  }


}