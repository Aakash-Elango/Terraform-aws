variable "ec2-key" {
	default = "terraform-key"
}

variable "ami"{
    default="ami-b70554c8"
}

resource "aws_security_group" "allow_ssh" {
	name        = "ec2-sg"
	description = "Allow all inbound ssh traffic "
	vpc_id     = "${aws_vpc.my-vpc.id}"
  
	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = {
		Name = "ec2-sg"
	}
}

resource "aws_instance" "instance" {
	ami = "${var.ami}"
	instance_type = "t2.micro"
	key_name = "${var.ec2-key}"
	security_groups = ["${aws_security_group.allow_ssh.id}"]
	subnet_id = "${aws_subnet.public-subnet1.id}"

	tags ={
		Name = "instance"
	}
}


