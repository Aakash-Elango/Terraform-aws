resource "aws_security_group" "allow_mysql" {
	name        = "db-sg"
	description = "Allow all inbound mysql traffic "
	vpc_id     = "${aws_vpc.my-vpc.id}"

	ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	tags = {
		Name = "db-sg"
	}
}

resource "aws_db_subnet_group" "rds_db_subnet_group" {
	name       = "main"
	subnet_ids = ["${aws_subnet.private-subnet1.id}","${aws_subnet.private-subnet2.id}"]

	tags = {
		Name = "My DB subnet group"
	}
}

resource "aws_db_instance" "mysql-db" {
	allocated_storage    = 20
	storage_type         = "gp2"
	engine               = "mysql"
	engine_version       = "5.7"
	instance_class       = "db.t2.micro"
    name                 = "mydb"
    username             = "admin"
    password             = "password"
    parameter_group_name = "default.mysql5.7"
    vpc_security_group_ids = ["${aws_security_group.allow_mysql.id}"]
    db_subnet_group_name = "${aws_db_subnet_group.rds_db_subnet_group.id}"
    final_snapshot_identifier = "foo"
    skip_final_snapshot       = true
}
