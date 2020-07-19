variable "instance_count" {
    default = 1
}

variable "ami_id" {}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet_id" {}