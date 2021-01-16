variable "AWS_REGION" {
  default = "eu-central-1"
}
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "S3_MEDIA_BUCKET" {}

variable "S3_STATIC_BUCKET" {}

variable "CDN_ACM_CERT_ARN" {}
variable "CDN_FQDN_MEDIA_ALIAS" {}
variable "CDN_FQDN_STATIC_ALIAS" {}

variable "CDN_MEDIA_DOMAIN" {}
variable "CDN_STATIC_DOMAIN" {}

variable "DOMAIN_ZONE_ID" {}

variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_INSTANCE_CLASS" {}

variable "DEVELOPER_ADDR" {}

variable "REDIS_INSTANCE_TYPE" {}

variable "ES_INSTANCE_TYPE" {}

variable "ALB_LOG_BUCKET" {}

variable "ELB_ACCOUNT_ID" {
  default = {
    us-east-1    = 127311923021
    us-east-2    = 033677994240
    us-west-2    = 797873946194
    eu-west-1    = 156460612806
    eu-central-1 = 054676820928
    eu-west-3    = 009996457667
  }
}

variable "AWS_ACCOUNT_ID" {}

variable "WEB_APP_DOMAIN" {}

variable "JUMPSERVER_INSTANCE_TYPE" {
  default = "t3a.medium"
}

variable "PUBLIC_KEY" {
  default = "magentokey.pub"
}

variable "ARTIFACT_USER" {}
variable "ARTIFACT_PASSWORD" {}
variable "SQL_ARTIFACT_URL" {}

variable "AMIS" {
  default = {
    eu-central-1 = "ami-0502e817a62226e03"
    us-east-2    = "ami-0a91cd140a1fc148a"
  }
}

variable "DOMAIN_CERT_ARN" {}