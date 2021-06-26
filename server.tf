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

resource "aws_internet_gateway" "Dev-igw" {
  vpc_id = aws_vpc.Devops_vpc.id

  tags = {
    Name = "main"
  }
}

resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.aws_vpc.Devops_vpc.id.default_route_table_id

  route {
    cidr_block = "172.16.0.0/16"
    gateway_id = aws_internet_gateway.Dev-igw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.Dev-igw.id
  }

  tags = {
    Name = "example"
  }
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

resource "aws_instance" "myawsserver" {
  ami = "ami-09e5afc68eed60ef4"
  subnet_id = aws_subnet.Server_subnet.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "Devops-KeyPair"
  user_data = <<-EOF
              #!/bin/bash
              sudo touch /jag
              sudo echo -e "Tech@2020\nTech@2020" | passwd root;
              sudo cp -p /etc/ssh/sshd_config /etc/ssh/sshd_config_backup;
              sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config;
              sudo sed -i 's/^PermitRootLogin*/PermitRootLogin yes/' /etc/ssh/sshd_config;
              sudo echo "PermitRootLogin yes" >> /etc/ssh/sshd_config;
              sudo systemctl restart sshd;
              EOF
   tags = {
    Name = "Mcms-ec2-instance"
    env = "test"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} >> /root/inv"
   
  }
  
    provisioner "local-exec" {
    command = "ssh-copy-id root@${self.public_ip}"
    
  }
    provisioner "local-exec" {
    command = "ssh 'root@${self.public_ip}'"
  }
}


