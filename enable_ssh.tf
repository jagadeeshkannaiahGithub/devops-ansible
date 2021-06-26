  resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_instance.myawsserver]

  create_duration = "60s"
}
