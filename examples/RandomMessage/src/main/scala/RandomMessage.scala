import java.util.Properties

import org.apache.kafka.clients.producer.{Callback, KafkaProducer, ProducerConfig, ProducerRecord, RecordMetadata}
import org.apache.kafka.common.serialization.{LongSerializer, StringSerializer}

import scala.util.Random

println("Class RandomMessage takes DNS and TOPIC parameters. TOPIC parameter will have 'prod.' prefix added and a suffix between 1 and 5.")

class RandomMessage(DNS: String, TOPIC: String) {

  private val kafkaProps = new Properties()
  private val port = if (DNS == "localhost") "9092" else "9990"
  private val bootstrapServer = DNS + ":" + port
  kafkaProps.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServer)
  kafkaProps.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, classOf[LongSerializer])
  kafkaProps.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, classOf[StringSerializer])

  private val producer = new KafkaProducer[Long, String](kafkaProps)

  println("bootstrap.Servers: " + bootstrapServer)

  //callback
  private trait ProducerCallback extends Callback {
    override def onCompletion(metadata: RecordMetadata, e: Exception) {
      if (e != null) {
        System.out.println(e)
        System.exit(1)
      }
    }
  }

  private def SimplestSend(topic: String, value: String): Unit = {
    val record = new ProducerRecord(topic, 1.toLong, value)
    try {
      val a = producer.send(record, new ProducerCallback{})
    } catch {
      case e: Exception => e.printStackTrace()
    }
  }

  private def RandomTopic(topic:String): String = {
    val r = Random
    return "prod." + topic + (r.nextInt(5) + 1)
  }

  def CreateMessages(numMessages:Int = 10): Unit = {
    for (i <- 1 to numMessages){
      //val topic = "testtopic"
      val topic = RandomTopic(TOPIC)
      val message = "This is message number " + i
      println("Topic: " + topic + ". Message: " + message)
      this.SimplestSend(topic, message)
      Thread.sleep(10)
    }
  }
}