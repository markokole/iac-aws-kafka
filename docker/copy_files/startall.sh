/usr/bin/nohup /opt/kafka_2.12-2.2.0/bin/zookeeper-server-start.sh /opt/kafka_2.12-2.2.0/config/zookeeper.properties > /tmp/zookeeper.out &
/usr/bin/nohup /opt/kafka_2.12-2.2.0/bin/kafka-server-start.sh /opt/kafka_2.12-2.2.0/config/server.properties > /tmp/kafka.out &
source /etc/profile
