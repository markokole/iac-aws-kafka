resource "aws_security_group" "sg_kafka_terraform" {
  name        = "sg_kafka_terraform"
  description = "Kafka provisioned from Terraform"
  vpc_id      = "${local.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "true"
    description = "Self"
  }

  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${local.cidr_blocks}"]
    description = "ssh"
  }

  # ssh
  ingress {
    from_port   = 9990
    to_port     = 9990
    protocol    = "tcp"
    cidr_blocks = ["${local.cidr_blocks}"]
    description = "Kafka external"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
