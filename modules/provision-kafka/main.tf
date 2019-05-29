module "provision_kafka" {
  source                 = "../instance"
  cluster_type           = "${var.cluster_type}"
}

locals {
  workdir         = "${path.cwd}/output"

  no_nodes        = "${data.consul_keys.kafka.var.no_nodes}"

  kafka_name      = "${module.provision_kafka.kafka_private_dns}"
  kafka_host      = "${module.provision_kafka.kafka_public_ip}"
}

resource "null_resource" "prepare_environment" {
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
                 ${path.module}/resources/prepare_environment.yml \
                 --extra-vars local_workdir=${local.workdir}
EOF
  }
}
