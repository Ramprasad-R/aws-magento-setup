output "base_url" {
  value = "https://${aws_route53_record.webapp.fqdn}/"
}

output "base_url_domain" {
  value = aws_route53_record.webapp.fqdn
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

output "magento_vpc_id" {
  value = aws_vpc.magento.id
}

output "magento_public_subnet" {
  value = aws_subnet.magento-public-1.id
}

output "media_bucket_name" {
  value = aws_s3_bucket.media-bucket.id
}

output "static_bucket_name" {
  value = aws_s3_bucket.static-bucket.id
}