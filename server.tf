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


resource "aws_instance" "myawsserver" {
  ami = "ami-0925a09a52d18d09a"
  subnet_id = aws_subnet.Server_subnet.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "Devops-KeyPair"
   tags = {
    Name = "Mcms-ec2-instance"
    env = "test"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} >> /root/inv"
  }
}


