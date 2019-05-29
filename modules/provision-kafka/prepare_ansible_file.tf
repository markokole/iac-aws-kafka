data "template_file" "generate_nodes_list" {
  count = "${local.no_nodes}"
  template = "${file("${path.module}/resources/templates/node_list.yml.tmpl")}"
  vars {
    node_text = "${element(local.kafka_name, count.index)} ansible_host=${element(local.kafka_host, count.index)} ansible_user=centos ansible_ssh_private_key_file=\"/home/centos/.ssh/id_rsa\""
    public_ips = "${element(local.kafka_host, count.index)}"
  }
}

# create the yaml file based on template and the input values
resource "local_file" "ansible_inventory_render" {
  content  = "${join("",data.template_file.generate_nodes_list.*.rendered)}"
  filename = "${local.workdir}/ansible-hosts"
}
