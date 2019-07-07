module "provision_kafka" {
  source            = "../instance"
  cluster_type      = "${var.cluster_type}"
}

locals {
  workdir           = "${path.cwd}/output"

  kafka_name        = "${module.provision_kafka.kafka_private_dns}"
  kafka_host        = "${module.provision_kafka.kafka_public_ip}"
  kafka_public_dns  = "${module.provision_kafka.kafka_public_dns}"

  no_nodes          = "${data.consul_keys.kafka.var.no_nodes}"
  zookeeper_url     = "${data.consul_keys.kafka.var.zookeeper_url}"
  kafka_url         = "${data.consul_keys.kafka.var.kafka_url}"
}


resource "null_resource" "install_kafka" {
  depends_on = ["module.provision_kafka"]

  provisioner "local-exec" {
    command = <<EOF
      sleep 20
EOF
  }

  provisioner "local-exec" {
    command = <<EOF
export ANSIBLE_HOST_KEY_CHECKING=False; \
ansible-playbook --inventory=${local.workdir}/ansible-hosts \
                 ${path.module}/resources/ansible/kafka.yml \
                 --extra-vars local_workdir=${local.workdir}
EOF
  }
}
