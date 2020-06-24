provider "aws" {
	access_key = "PASTE-ACCESS-KEY"
	secret_key = "PASTE-SECRET-KEY"
	region     = "us-east-1"
}

resource "aws_instance" "windows-server" {
	ami           	= "ami-05bb2dae0b1de90b3"
	instance_type 	= "t2.micro"
	key_name 		= "terraform-key"
	security_groups = ["${aws_security_group.allow-rdp-port.name}"]
	tags = {
		Name = "terraform-windows-server"
	}
}

resource "aws_security_group" "allow-rdp-port" {
	name        = "windows-sg"
	description = "Allow all inbound rdp traffic"
	ingress {
		from_port   = 3389
		to_port     = 3389
		protocol =   "tcp"
		cidr_blocks =  ["0.0.0.0/0"]
	}
	tags = {
		Name = "windows-sg"
	}
}