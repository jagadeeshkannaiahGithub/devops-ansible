provider "aws" {
region = "eu-west-2"
}
resource "aws_instance" "myawsserver" {
  ami = "ami-09e5afc68eed60ef4"
  instance_type = "t2.micro"
  key_name = "ansible-master-server"

  tags = {
    Name = "Mcms-ec2-instance"
    env = "test"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} >> /root/inv"
  }
}

