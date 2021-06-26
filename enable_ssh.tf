  resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_instance.myawsserver]

  create_duration = "60s"
}
resource "aws_instance" "myawsserver" {
  provisioner "remote-exec" {
   command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} >> /root/inv"
   depends_on = [time_sleep.wait_60_seconds]
  }
}
