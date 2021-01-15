output "base_url" {
  value = "https://${aws_route53_record.webapp.fqdn}/"
}

output "media_base_url" {
  value = "https://${aws_route53_record.cdn-media-domain.fqdn}/"
}

output "static_base_url" {
  value = "https://${aws_route53_record.cdn-static-domain.fqdn}/"
}

output "redis_server" {
  value = aws_elasticache_cluster.magento.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.magento.cache_nodes[0].port
}

output "elastic_search_endpoint" {
  value = "https://${aws_elasticsearch_domain.magento-es.endpoint}"
}

output "mysql_host" {
  value = aws_db_instance.magento.address
}

output "jump_server" {
  value = aws_instance.jump-server.public_ip
}