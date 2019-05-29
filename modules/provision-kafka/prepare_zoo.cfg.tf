data "template_file" "generate_zoo_cfg" {
  count = "${local.no_nodes}"
  template = "${file("${path.module}/resources/templates/zoo.cfg.tmpl")}"
  vars {
    zookeeper_home = "/opt/zookeeper-3.4.14"
    kafka_servers = "server.${count.index + 1}=${element(local.kafka_name, count.index)}:2888:3888"
  }
}

# create the yaml file based on template and the input values
resource "local_file" "zoo_cfg_render" {
  content  = "${join("",data.template_file.generate_zoo_cfg.*.rendered)}"
  filename = "${local.workdir}/zoo.cfg"
}
