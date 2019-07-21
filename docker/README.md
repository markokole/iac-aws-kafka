# Create Docker container with single-node Kafka for test and development

## Build, Run and Execute Docker

docker build . --tag=kafka-image
docker run -itd --rm --name kafka --hostname kafka -v C:\marko\GitHub\iac-aws-kafka:/local-git kafka-image
docker exec -it kafka bash

Inside the *kafka* container is a zookeeper service running and on top of it the kafka service. This container can now be used for test and development locally before going into the *modules* folder where the code to provision a kafka cluster on AWS is located.
