resource "aws_launch_configuration" "as_conf" {
  name          = "web_config"
  image_id      = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.us-east-1-key.id}"
  user_data     = "${file("userdata.sh")}"

  security_groups             = ["${aws_security_group.asg-sec-group.id}"]
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "cisco-asg" {
  name                 = "cisco-asg"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  health_check_type    = "ELB"

  vpc_zone_identifier = [
    "${aws_subnet.public1.id}",
    "${aws_subnet.public2.id}",
    "${aws_subnet.public3.id}",
  ]

  # availability_zones = [
  #   "${var.region}a",
  #   "${var.region}b",
  #   "${var.region}c",
  # ]

  desired_capacity = "${var.desired_capacity}"
  max_size         = "${var.max_size}"
  min_size         = "${var.min_size}"

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "${var.asg_tag}"
    propagate_at_launch = true
  }
}
