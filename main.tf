
terraform {
  backend "atlas" {
    name    = "pthrasher/training"
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami             = "ami-c58c1dd3"
  instance_type   = "t2.micro"
  security_groups = ["sg-e38c9b87"]
  key_name        = "vastermonster"
  subnet_id       = "subnet-1523252f"

  tags {
    Name  = "Hello World"
    Owner = "Terraform"
  }
}
