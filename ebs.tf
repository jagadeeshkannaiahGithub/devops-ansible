resource "aws_ebs_volume" "ec2-ebs" {
  availability_zone = "eu-west-2a"
  size              = 10

  tags = {
    Name = "HelloWorld"
  }
}
  
 
