output "kafka_public_ip" {
  value = "${local.kafka_host}"
}

output "kafka_public_dns" {
  value = "${local.kafka_public_dns}"
}
