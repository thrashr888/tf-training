provider "aws" {
  region = "us-east-1"
}

# data "aws_ami" "amazon" {
#   most_recent = true

#   filter {
#     name   = "owner-alias"
#     values = ["amazon"]
#   }

#   filter {
#     name   = "name"
#     values = ["Amazon Linux AMI *"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

resource "aws_instance" "web" {
#   ami           = "${data.aws_ami.amazon.id}"
  ami="ami-c58c1dd3"
  instance_type = "t2.micro"
  security_groups = ["sg-ac29cfc5"]

  tags {
    Name = "HelloWorld"
    Owner = "Terraform"
  }
}