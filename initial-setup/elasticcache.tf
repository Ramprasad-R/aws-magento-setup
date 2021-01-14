resource "aws_elasticache_cluster" "magento" {
  cluster_id           = "cluster-magento"
  engine               = "redis"
  node_type            = var.REDIS_INSTANCE_TYPE
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.0.5"
  port                 = 6379
}