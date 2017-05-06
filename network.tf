resource "aws_vpc" "test_vpc" {
  cidr_block                       = "172.30.0.0/16"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  enable_classiclink               = false
  assign_generated_ipv6_cidr_block = false

  tags {
    Name = "Main"
  }
}

resource "aws_subnet" "MainA" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "172.30.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags {
    Name = "Main a"
  }
}

resource "aws_subnet" "MainB" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "172.30.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags {
    Name = "Main b"
  }
}

resource "aws_subnet" "MainD" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "172.30.3.0/24"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = true

  tags {
    Name = "Main d"
  }
}

resource "aws_subnet" "MainE" {
  vpc_id                  = "${aws_vpc.test_vpc.id}"
  cidr_block              = "172.30.4.0/24"
  availability_zone       = "us-east-1e"
  map_public_ip_on_launch = true

  tags {
    Name = "Main e"
  }
}

resource "aws_internet_gateway" "Main" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  tags {
    Name = "Main"
  }
}

# resource "aws_egress_only_internet_gateway" "egress" {
#   vpc_id = "${aws_vpc.test_vpc.id}"
# }

resource "aws_route" "Main" {
  route_table_id         = "${aws_route_table.Main.id}"
  destination_cidr_block = "0.0.0.0/0"
  
  #   destination_ipv6_cidr_block  = "::/0"
  #   egress_only_gateway_id = "${aws_egress_only_internet_gateway.egress.id}"
}


resource "aws_route_table" "Main" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  # route {
  #     cidr_block = "172.30.0.0/16"
  # }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.Main.id}"
  }
  tags {
    Name = "Main"
  }
}

resource "aws_main_route_table_association" "Main" {
  vpc_id         = "${aws_vpc.test_vpc.id}"
  route_table_id = "${aws_route_table.Main.id}"
}

resource "aws_route_table_association" "Main" {
  subnet_id      = "${aws_subnet.MainB.id}"
  route_table_id = "${aws_route_table.Main.id}"
}

resource "aws_route_table_association" "Main-1" {
  subnet_id      = "${aws_subnet.MainA.id}"
  route_table_id = "${aws_route_table.Main.id}"
}

resource "aws_route_table_association" "Main-2" {
  subnet_id      = "${aws_subnet.MainD.id}"
  route_table_id = "${aws_route_table.Main.id}"
}

resource "aws_route_table_association" "Main-3" {
  subnet_id      = "${aws_subnet.MainE.id}"
  route_table_id = "${aws_route_table.Main.id}"
}

resource "aws_security_group" "default_group" {
  name        = "default"
  description = "default group"

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "TCP"
    security_groups = ["sg-ac29cfc5"]
  }

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "UDP"
    security_groups = ["sg-ac29cfc5"]
  }

  # ingress {
  #   from_port       = 0
  #   to_port         = 65535
  #   protocol        = "IMCP"
  #   security_groups = ["sg-ac29cfc5"]
  # }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # MySQL
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # PostgreSQL
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   ingress {
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }


  #   egress {
  #     from_port       = 0
  #     to_port         = 0
  #     protocol        = "-1"
  #     cidr_blocks     = ["0.0.0.0/0"]
  #     prefix_list_ids = ["pl-12c4e678"]
  #   }

  tags {
    Name = "default"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.test_vpc.id}"

  ingress {
    protocol    = -1
    self        = false
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "All Open"
  }
}
