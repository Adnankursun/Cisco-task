resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_block}"
  tags       = "${var.tags}"
}

resource "aws_subnet" "public1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_cidr1}"
  availability_zone = "${var.region}a"
  tags              = "${var.tags}"
}

resource "aws_subnet" "public2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_cidr2}"
  availability_zone = "${var.region}b"
  tags              = "${var.tags}"
}

resource "aws_subnet" "public3" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_cidr3}"
  availability_zone = "${var.region}c"
  tags              = "${var.tags}"
}

resource "aws_subnet" "private1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_cidr1}"
  availability_zone = "${var.region}a"
  tags              = "${var.tags}"
}

resource "aws_subnet" "private2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_cidr2}"
  availability_zone = "${var.region}b"
  tags              = "${var.tags}"
}

resource "aws_subnet" "private3" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.private_cidr3}"
  availability_zone = "${var.region}c"
  tags              = "${var.tags}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_security_group" "asg-sec-group" {
  name        = "asg-sec-group"
  description = "Allow TLS inbound traffic"

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
    Name = "allow_tls"
  }
}
