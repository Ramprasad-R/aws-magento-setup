data "template_file" "shell-script-jumpserver" {
  template = file("scripts/jumpserver-init.sh")
  vars = {
    mysql_host        = aws_db_instance.magento.address
    ARTIFACT_USER     = var.ARTIFACT_USER
    ARTIFACT_PASSWORD = var.ARTIFACT_PASSWORD
    SQL_ARTIFACT_URL  = var.SQL_ARTIFACT_URL
    RDS_USERNAME      = var.RDS_USERNAME
    RDS_PASSWORD      = var.RDS_PASSWORD
    base_url = "https://${aws_route53_record.webapp.fqdn}/"
    base_static_url = "https://${aws_route53_record.cdn-static-domain.fqdn}/"
    base_media_url = "https://${aws_route53_record.cdn-media-domain.fqdn}/"
  }
}

data "template_cloudinit_config" "jumpserver-cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.shell-script-jumpserver.rendered
  }

}
