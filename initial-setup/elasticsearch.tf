resource "aws_elasticsearch_domain" "magento-es" {
  domain_name           = "magento"
  elasticsearch_version = "7.9"

  cluster_config {
    instance_type = var.ES_INSTANCE_TYPE
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  ebs_options {
    volume_type = "gp2"
    volume_size = 10
    ebs_enabled = true
  }

  tags = {
    Name = "magento-es"
  }
}