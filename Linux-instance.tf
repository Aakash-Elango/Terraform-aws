provider "aws" {
	access_key = "#######################"
	secret_key = "#############################"
	region     = "us-east-1"
}

resource "aws_instance" "linux-server" {
	ami           = "ami-085925f297f89fce1"
	instance_type = "t2.micro"
	key_name      = "terraform-key"
}