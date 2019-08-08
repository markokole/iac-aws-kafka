# Create Docker container with single-node Kafka for test and development

## Build, Run and Execute Docker

```bash
docker build . --tag=kafka-image
docker run -itd --rm --name kafka --hostname kafka -v C:\marko\GitHub\iac-aws-kafka:/local-git kafka-image
docker exec -it kafka bash
```

Inside the *kafka* container, zookeeper and kafka are installed and can be started by executing the /opt/startall.sh script. Scala is also installed in case user wishes to test Scala programs against Kafka cluster in the cloud and requires a client.

This container can be used for test and development locally before running the Kafka provisioning code in the modules folder.
