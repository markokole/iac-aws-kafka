# Provision Kafka cluster on AWS with Terraform

## Idea

Provision Kafka cluster in AWS from code. This repository is on of many in the series of *infrastructure-as-code* in my GitHub repository. There are several repositories starting with *iac-aws-* and they all provision some service on AWS with Terraform.

The *docker* folder contains DockerFile that builds a kafka container for test and development on a local machine. The folder *provision-kafka* holds files that provision a kafka cluster to AWS.

## Prerequisities

### Infrastructure on AWS

Make sure the infrastructure is setup before continuing. Run `consul kv get -recurse | grep aws/generated` to check if all services in AWS are up and running. If everything is ok, you should se multiple lines with word *generated* in the output. If not, [clone this repository](https://github.com/markokole/iac-aws-vpc) to prepare the infrastructure.
