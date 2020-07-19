provider "aws" {
	region     = "us-east-1"
}

module "my-vpc" {
    source = "../modules/vpc"
    vpc_cidr = "192.68.0.0/16"
    tenancy = "default"
    vpc_id = module.my-vpc.vpc_id
    subnet_cidr = "192.68.1.0/24"
}

module "my-ec2" {
    source = "../modules/ec2"
    instance_count = 1
    ami_id = "ami-085925f297f89fce1"
    instance_type = "t2.micro"
    subnet_id = module.my-vpc.subnet_id
}