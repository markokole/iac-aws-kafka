#output "instance_id" {
#  value = "${aws_instance.spark_master.*.id}"
#}

output "kafka_public_dns" {
  value = "${aws_instance.kafka_cluster.*.public_dns}"
}

output "kafka_public_ip" {
  value = "${aws_instance.kafka_cluster.*.public_ip}"
}

output "kafka_private_dns" {
  value = "${aws_instance.kafka_cluster.*.private_dns}"
}
