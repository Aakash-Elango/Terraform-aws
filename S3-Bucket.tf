provider "aws" {
	access_key = "PASTE-ACCESS-KEY"
	secret_key = "PASTE-SECRET-KEY"
	region     = "us-east-1"
}

resource "aws_s3_bucket" "fresh-bucket" {
  bucket = "my-bucket-aakash-elango"
  acl    = "private"
  versioning {
    enabled = true
  }
  tags = {
    Name        = "fresh bucket"
    Environment = "Testing"
  }
}