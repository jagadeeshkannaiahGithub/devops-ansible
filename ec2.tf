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
