resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-local-bucket"
  acl    = "private"
}

