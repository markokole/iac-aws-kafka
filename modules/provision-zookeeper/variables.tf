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
    name    = "ami"
    path    = "${var.path_in_consul}/ami_id"
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
  key {
    name    = "zookeeper_url"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/zookeeper_url"
  }
  key {
    name    = "kafka_url"
    path    = "${var.path_in_consul_kafka}/${var.cluster_type}/kafka_url"
  }
}
