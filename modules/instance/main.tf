provider "aws" {
  region = "${local.region}"
}

locals {
  #app
  path_to_generated_aws_properties = "${var.path_in_consul}/${data.consul_keys.app.var.path_to_generated_aws_properties}"
  region               = "${data.consul_keys.app.var.region}"
  cidr_blocks          = "${data.consul_keys.app.var.cidr_blocks}"

  #aws
  vpc_id               = "${data.consul_keys.aws.var.vpc_id}"
  subnet_id            = "${data.consul_keys.aws.var.subnet_id}"
  availability_zone    = "${data.consul_keys.aws.var.availability_zone}"

  #kafka
  ami                  = "${data.consul_keys.kafka.var.ami}"
  no_nodes             = "${data.consul_keys.kafka.var.no_nodes}"
  instance_type        = "${data.consul_keys.kafka.var.instance_type}"
  instance_tag         = "${data.consul_keys.kafka.var.instance_tag}"

  security_groups      = ["${aws_security_group.sg_kafka_terraform.id}"]

}



resource "aws_instance" "kafka_cluster" {
  depends_on = ["aws_security_group.sg_kafka_terraform"]

  count = "${local.no_nodes}"
  ami = "${local.ami}"
  instance_type = "${local.instance_type}"
  subnet_id = "${local.subnet_id}"
  security_groups = ["${local.security_groups}"]
  availability_zone = "${local.availability_zone}"
  key_name = "mykeypair"
  associate_public_ip_address = "true"
  tags {
    Name = "kafka-${local.instance_tag}-${format("%02d", count.index + 1)}"
  }
  volume_tags {
    Name = "kafka-volume-${local.instance_tag}-${format("%02d", count.index + 1)}"
  }

  root_block_device {
    volume_size = 50
    volume_type = "gp2"
    delete_on_termination = "true"
  }
}
