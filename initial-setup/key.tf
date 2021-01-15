resource "aws_key_pair" "magento-key" {
  key_name   = "magento-key"
  public_key = file(var.PUBLIC_KEY)
}
