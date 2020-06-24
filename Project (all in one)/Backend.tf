terraform {
  backend "s3" {
    bucket = "my-bucket-aakash-elango"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}