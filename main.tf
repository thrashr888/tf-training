terraform {
  backend "atlas" {
    name = "pthrasher/training"
  }
  required_version = "> 0.9.3"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami             = "ami-c58c1dd3"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.default_group.id}"]
  key_name        = "vastermonster"
  subnet_id       = "${aws_subnet.MainA.id}"

  tags {
    Name  = "Hello World"
    Owner = "Terraform"
  }
}
