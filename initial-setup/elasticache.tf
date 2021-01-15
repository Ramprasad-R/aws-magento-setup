resource "aws_elasticache_subnet_group" "magento-ec-subnet" {
  name       = "magento-ec-subnet"
  subnet_ids = [aws_subnet.magento-private-1.id]
}

resource "aws_elasticache_cluster" "magento" {
  cluster_id           = "cluster-magento"
  engine               = "redis"
  node_type            = var.REDIS_INSTANCE_TYPE
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.0.5" #https://github.com/hashicorp/terraform-provider-aws/issues/15625
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.magento-ec-subnet.name
  security_group_ids   = [aws_security_group.ec-sg.id]
}