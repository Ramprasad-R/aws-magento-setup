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