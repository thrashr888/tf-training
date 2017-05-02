provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami="ami-c58c1dd3"
  instance_type = "t2.micro"
  security_groups = ["ac29cfc5"]
  key_name = "vastermonster"

  tags {
    Name = "Hello World"
    Owner = "Terraform"
  }
}
