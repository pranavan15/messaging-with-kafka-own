package KafkaPublisher;

import ballerina.net.kafka;
import ballerina.net.http;

service<http> productAdminService {
    resource updatePrice(http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        string msg = "Hello World Advanced";
        blob serializedMsg = msg.toBlob("UTF-8");
        // We create ProducerRecord which consist of advanced optional parameters.
        // Here we set valid partition number which will be used when sending the record.
        kafka:ProducerRecord record = { value:serializedMsg, topic:"product-price", partition:1 };

        // We create a producer configs with optional parameters client.id - used for broker side logging.
        // Acks - number of acknowledgments for request complete, noRetries - number of retries if record send fails.
        kafka:ProducerConfig producerConfig = { clientID:"basic-producer", acks:"all", noRetries:3};
        kafkaAdvancedProduce(record, producerConfig);
    }
}

function kafkaAdvancedProduce(kafka:ProducerRecord record, kafka:ProducerConfig producerConfig) {
    endpoint<kafka:ProducerClient> kafkaEP {
        create kafka:ProducerClient (["localhost:9092, localhost:9093"], producerConfig);
    }
    kafkaEP.sendAdvanced(record);
    kafkaEP.flush();
    kafkaEP.close();
}