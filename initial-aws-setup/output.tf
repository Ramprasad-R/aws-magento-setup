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

output "ssh_key_name" {
  value = aws_key_pair.magento-key.key_name
}

output "magento_ec2_sg" {
  value = aws_security_group.web-app-sg.id
}

output "private_subnet_1" {
  value = aws_subnet.magento-private-1.id
}

output "private_subnet_2" {
  value = aws_subnet.magento-private-2.id
}

output "private_subnet_3" {
  value = aws_subnet.magento-private-3.id
}

output "target_group_arn" {
  value = module.alb.target_group_arns[0]
}

output "s3_media_bucket" {
  value = "s3://${aws_s3_bucket.media-bucket.id}/"
}

output "s3_static_bucket" {
  value = "s3://${aws_s3_bucket.static-bucket.id}/"
}

output "magento_instance_role" {
  value = aws_iam_role.magento-instance-role.id
}