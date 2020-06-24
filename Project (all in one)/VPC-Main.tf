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

resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "ngw" {
	allocation_id = "${aws_eip.nat.id}"
	subnet_id     = "${aws_subnet.public-subnet1.id}"

	tags = {
		Name = "NAT-gw"
	}
}


resource "aws_subnet" "private-subnet1" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.1.0/24"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = false

	tags = {
		Name = "private-subnet1"
	}
}

resource "aws_subnet" "private-subnet2" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.3.0/24"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = false

	tags = {
		Name = "private-subnet2"
	}
}

resource "aws_subnet" "public-subnet1" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.2.0/24"
	availability_zone = "us-east-1a"
	map_public_ip_on_launch = true

	tags = {
		Name = "public-subnet1"
	}
}

resource "aws_subnet" "public-subnet2" {
	vpc_id     = "${aws_vpc.my-vpc.id}"
	cidr_block = "10.0.4.0/24"
	availability_zone = "us-east-1b"
	map_public_ip_on_launch = true
  
	tags = {
		Name = "public-subnet2"
	}
}

resource "aws_main_route_table_association" "main_route_table_association" {
	vpc_id         = "${aws_vpc.my-vpc.id}"
	route_table_id = "${aws_route_table.private-rt.id}"
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


resource "aws_route_table" "private-rt" {
	vpc_id     = "${aws_vpc.my-vpc.id}"

	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${aws_nat_gateway.ngw.id}"
	}

	tags = {
		Name = "private-subnet-rt"
	}
}

resource "aws_route_table_association" "private1-rt-association" {
	subnet_id      = aws_subnet.private-subnet1.id 
	route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "private2-rt-association" {
	subnet_id      = aws_subnet.private-subnet2.id 
	route_table_id = aws_route_table.private-rt.id
}


resource "aws_route_table_association" "public1-rt-association" {
	subnet_id      = aws_subnet.public-subnet1.id
	route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "public2-rt-association" {
	subnet_id      = aws_subnet.public-subnet2.id
	route_table_id = aws_route_table.public-rt.id
}
