#WIP

# Provision Kafka cluster on AWS with the use of Terraform


## Idea
Provision Kafka cluster in AWS from code.

## Prerequisities

### Infrastructure on AWS
Make sure the infrastructure is setup before continuing. Run `consul kv get -recurse | grep aws/generated` to check if all services in AWS are up and running. If not, [clone this repository](https://github.com/markokole/iac-aws-vpc) to prepare the infrastructure.
