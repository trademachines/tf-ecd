resource "aws_s3_bucket" "ecd_configs" {
  bucket = "${var.s3_bucket_name}"
  acl = "private"
}
