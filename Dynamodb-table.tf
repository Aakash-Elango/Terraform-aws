provider "aws" {
	region     = "us-east-1"
}

resource "aws_dynamodb_table" "Employee" {
  name             = "Employee"
  hash_key         = "EmployeeID"
  range_key        = "EmployeeName"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  stream_enabled   = false

# type - Attribute type, which must be a scalar type: S, N, or B for (S)tring, (N)umber or (B)inary data

  attribute {
    name = "EmployeeID"
    type = "N"
  }
  attribute {
    name = "EmployeeName"
    type = "S"
  }
  ttl {
    attribute_name = "TimeToLive"
    enabled        = false
  }
  tags = {
    Name        = "dynamodb-table"
    Environment = "testing"
  }
}