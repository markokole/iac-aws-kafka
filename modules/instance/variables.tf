variable "cluster_type" {}

variable "path_in_consul" {
  default   = "test/master/aws"
}

variable "path_in_consul_kafka" {
  default   = "test/master/kafka"
}

variable "consul_server" {
  default   = "127.0.0.1"
}

variable "consul_port" {
  default   = "8500"
}

variable "datacenter" {
  default   = "dc1"
}

data "consul_keys" "app" {
  key {
    name    = "region"
    path    = "${var.path_in_consul}/region"
  }
  key {
    name    = "path_to_generated_aws_properties"
    path    = "${var.path_in_consul}/path_to_generated_aws_properties"
  }
  key {
    name    = "cidr_blocks"
    path    = "${var.path_in_consul}/route_table_cidr_block_all"
  }
  key {
    name    = "ami"
    path    = "${var.path_in_consul}/ami_id"
  }
}

data "consul_keys" "aws" {
  key {
    name    = "vpc_id"
    path    = "${local.path_to_generated_aws_properties}/vpc_id"
  }
  key {
    name    = "availability_zone"
    path    = "${local.path_to_generated_aws_properties}/availability_zone"
  }
  key {
    name    = "subnet_id"
    path    = "${local.path_to_generated_aws_properties}/subnet_id"
  }
  key {
  name    = "key_pair"
  path    = "${var.path_in_consul}/key_pair"
}
}

data "consul_keys" "kafka" {
  key {
    name    = "ami"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/ami"
    default = "${data.consul_keys.app.var.ami}"
  }
  key {
    name    = "no_nodes"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/no_nodes"
  }
  key {
    name    = "instance_type"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/instance_type"
  }
  key {
    name    = "instance_tag"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/instance_tag"
  }
}
