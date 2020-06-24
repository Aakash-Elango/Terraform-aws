provider "aws" {
	access_key = "PASTE-ACCESS-KEY"
	secret_key = "PASTE-SECRET-KEY"
	region     = "us-east-1"
}

resource "aws_instance" "linux-server" {
	ami           	= "ami-085925f297f89fce1"
	instance_type 	= "t2.micro"
	security_groups = ["${aws_security_group.allow-ssh-port.name}"]
	key_name 		= "terraform-key"
}

resource "aws_security_group" "allow-ssh-port" {
	name        = "linux-sg"
	description = "Allow all inbound ssh traffic"
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "linux-sg"
	}
}