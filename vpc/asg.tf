resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = "ami-01aad86525617098d"
  instance_type = "t2.micro"
  key_name      = "asg-key-pair"
  user_data     = "${file("userdata.sh")}"

  
}

resource "aws_autoscaling_group" "bar" {
  name                 = "cisco-asg-example"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"

  availability_zones = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]

  min_size = 2
  max_size = 4

  lifecycle {
    create_before_destroy = true
  }
}
