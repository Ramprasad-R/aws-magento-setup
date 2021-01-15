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

output "elasticsearch_endpoint" {
  value = aws_elasticsearch_domain.magento-es.endpoint
}