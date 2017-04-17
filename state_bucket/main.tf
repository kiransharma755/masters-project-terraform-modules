provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}
