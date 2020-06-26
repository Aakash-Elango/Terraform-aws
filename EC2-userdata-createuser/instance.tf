provider "aws" {
	access_key = "PASTE-ACCESS-KEY"
	secret_key = "PASTE-SECRET-KEY"
	region     = "us-east-1"
}

data "template_file" "create-user" {
    template = "${file("myscript.sh")}"
}


resource "aws_instance" "linux-server" {
	ami           	= "ami-098f16afa9edf40be"
	instance_type 	= "t2.micro"
	instance_count  = 5
	security_groups = ["${aws_security_group.allow-ssh-port.name}"]
	key_name        = "us-test"
	user_data       = "${data.template_file.create-user.rendered}"
	tags = {
		Name = "Redhat-instance"
	}
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
	ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "linux-sg"
	}
}
