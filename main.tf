provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami="ami-c58c1dd3"
  instance_type = "t2.micro"
  security_groups = ["sg-ac29cfc5"]

  tags {
    Name = "Hello World"
    Owner = "Terraform"
  }
}
