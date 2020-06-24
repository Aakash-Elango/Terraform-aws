provider "aws" {
	access_key = "PASTE-ACCESS-KEY"
	secret_key = "PASTE-SECRET-KEY"
	region     = "us-east-1"
}

resource "aws_vpc" "my-vpc" {
	cidr_block = "10.0.0.0/16"

	tags = {
		Name = "my-vpc"
	}
}

resource "aws_internet_gateway" "igw" {
	vpc_id = "${aws_vpc.my-vpc.id}"

	tags = {
		Name = "IGW"
	}
}

resource "aws_subnet" "public-subnet" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.2.0/24"
  
	tags = {
		Name = "public-subnet"
	}
}

resource "aws_subnet" "private-subnet" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.1.0/24"

	tags = {
		Name = "private-subnet1"
	}
}

resource "aws_route_table" "public-rt" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.igw.id}"
	}

	tags = {
		Name = "public-subnet-rt"
	}
}