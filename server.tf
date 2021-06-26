provider "aws" {
region = "eu-west-2"

}

resource "aws_vpc" "Devops_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "Devops_vpc"
  }
}

resource "aws_subnet" "Server_subnet" {
  vpc_id            = aws_vpc.Devops_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "tf-example"
  }
}

resource "aws_internet_gateway" "Dev_gw" {
  vpc_id = aws_vpc.Devops_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_route" "simulation_default_route" {
  route_table_id         = "${aws_vpc.Devops_vpc.default_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.Dev_gw.id}"
}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.Devops_vpc.id

  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

    


