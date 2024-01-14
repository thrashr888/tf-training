terraform {
  backend "atlas" {
    name = "pthrasher/training"
  }

  required_version = ">= 0.9.5"
}

provider "atlas" {}

#data "atlas_artifact" "vastermonster" {
#  name  = "pthrasher/vastermonster"
#  type  = "amazon.image"
#  build = "latest"
#}
#data "atlas_artifact" "paulthrasher" {
#  name  = "pthrasher/paulthrasher"
#  type  = "amazon.image"
#  build = "latest"
#}

provider "aws" {
  region = "us-east-1"
}

resource "aws_eip" "classic1" {
  instance = "${aws_instance.web_old.id}"
  vpc      = false
}

resource "aws_instance" "web_old" {
  ami                     = "ami-23a12835"                           # vastermonster-bak-4
  instance_type           = "t1.micro"
  security_groups         = ["default"]
  key_name                = "${aws_key_pair.vastermonster.key_name}"
  availability_zone       = "us-east-1d"
  disable_api_termination = true
  source_dest_check       = false

  tags {
    Name = "web-03-v8"
  }

  volume_tags {
    Name  = "web-03-v8"
    Owner = "Terraform"
  }
}

resource "aws_eip" "vpc1" {
  instance = "${aws_instance.vastermonster.id}"
  vpc      = true
}

resource "aws_instance" "vastermonster" {
  ami                    = "ami-23a12835"
  instance_type          = "t2.nano"
  vpc_security_group_ids = ["${aws_default_security_group.default.id}"]
  key_name               = "${aws_key_pair.vastermonster.key_name}"
  subnet_id              = "${aws_subnet.MainA.id}"

  connection {
    user     = "ec2-user"
    key_file = "~/.ssh/vastermonster.pem"
  }

  tags {
    Name  = "vastermonster-01"
    Owner = "Terraform"
  }
}

resource "aws_eip" "vpc2" {
  instance = "${aws_instance.paulthrasher.id}"
  vpc      = true
}

resource "aws_instance" "paulthrasher" {
  ami                    = "ami-23a12835"
  instance_type          = "t2.nano"
  vpc_security_group_ids = ["${aws_default_security_group.default.id}"]
  key_name               = "${aws_key_pair.vastermonster.key_name}"
  subnet_id              = "${aws_subnet.MainA.id}"

  connection {
    user     = "ec2-user"
    key_file = "~/.ssh/vastermonster.pem"
  }

  tags {
    Name  = "paulthrasher-01"
    Owner = "Terraform"
  }
}

resource "aws_key_pair" "vastermonster" {
  key_name   = "vastermonster"
  public_key = ""
}

resource "aws_key_pair" "thrashr888_id_rsa" {
  key_name   = "thrashr888.id_rsa"
  public_key = ""
}

resource "aws_key_pair" "thrashr888_id_rsa_pass" {
  key_name   = "thrashr888.id_rsa_pass"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDmi6JtgxUk/KbuWfw48rI8heEuFqVbWTd2bYgjZDdajeyS/bD0Txn+mYphiRccHN6xRz0d6cZwa1og1H+REzKpMlYgry6iaSnAzalmHUsCx/xqfAcH1dBEUBqrr6j5jHXyZrQo70SfiqsCQi+ruqjOGEwUIJ6Forh0hEPubuFnZrbJfgxDSu8d/yf1VFXq9hmqzU8QA98959gi88tODvYcKMYCIXUsaWQtP5DcIxkgvoUR6v/LkLJv3OI5w/FBsWSSnfpKqxQTSU3vICCzAPGtVmkPmo3b1ZZp5PfL3369UnfQr192Rd7ttm5Fd5+YyDRv3wWYWkK3CFf7IpxQD6XT pthrasher@saymedia.com"
}

output "region" {
  value = "us-east-1"
}

output "web_old_ip" {
  value = "${aws_instance.web_old.public_ip}"
}

output "vastermonster_ip" {
  value = "${aws_instance.vastermonster.public_ip}"
}
output "paulthrasher_ip" {
  value = "${aws_instance.paulthrasher.public_ip}"
}
