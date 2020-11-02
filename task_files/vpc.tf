resource "aws_vpc" "cisco" {
  cidr_block = "${var.cidr_block}"

  tags = {
    Name = "cisco vpc"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.public_cidr1}"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Public Subneta"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.public_cidr2}"
  availability_zone = "${var.region}b"

  tags = {
    Name = "Public Subnetb"
  }
}

resource "aws_subnet" "public3" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.public_cidr3}"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Public Subnetc"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.private_cidr1}"
  availability_zone = "${var.region}a"

  tags = {
    Name = "Private Subneta"
  }
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.private_cidr2}"
  availability_zone = "${var.region}b"

  tags = {
    Name = "Private Subnetb"
  }
}

resource "aws_subnet" "private3" {
  vpc_id            = "${aws_vpc.cisco.id}"
  cidr_block        = "${var.private_cidr3}"
  availability_zone = "${var.region}c"

  tags = {
    Name = "Private Subnetc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.cisco.id}"

  tags = {
    Name = "Cisco VPC - Internet Gateway"
  }
}

resource "aws_route_table" "cisco_vpc_public" {
  vpc_id = "${aws_vpc.cisco.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "Public Subnets Route Table for My Cisco VPC"
  }
}

resource "aws_route_table_association" "cisco_vpc_public_a" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.cisco_vpc_public.id}"
}

resource "aws_route_table_association" "cisco_vpc_public_b" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.cisco_vpc_public.id}"
}

resource "aws_route_table_association" "cisco_vpc_public_c" {
  subnet_id      = "${aws_subnet.public3.id}"
  route_table_id = "${aws_route_table.cisco_vpc_public.id}"
}

resource "aws_security_group" "asg-sec-group" {
  name        = "asg-sec-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.cisco.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow HTTP_SSH Security Group"
  }
}
