module "web1" {
  source       = "../task_files"

  region       = "${var.region}"
  cidr_block   = "${var.cidr_block}"
  public_cidr1 = "${var.public_cidr1}"
  public_cidr2 = "${var.public_cidr2}"
  public_cidr3 = "${var.public_cidr3}"

  private_cidr1 = "${var.private_cidr1}"
  private_cidr2 = "${var.private_cidr2}"
  private_cidr3 = "${var.private_cidr3}"

  ami_id             = "${var.ami_id}"
  asg_tag            = "${var.asg_tag}"
  desired_capacity   = "${var.desired_capacity}"
  max_size           = "${var.max_size}"
  min_size           = "${var.min_size}"
  launch-config-name = "${var.launch-config-name}"
}

