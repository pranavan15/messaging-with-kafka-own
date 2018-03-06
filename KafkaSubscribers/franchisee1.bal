package KafkaSubscribers;

import ballerina.net.kafka;
import ballerina.log;

@Description {value:"Service level annotation to provide Kafka consumer configuration. Here enable.auto.commit = false"}
@kafka:configuration {
    bootstrapServers:"localhost:9092, localhost:9093",
    groupId:"franchisee1",
    topics:["product-price"],
    pollingInterval:1000
}
service<kafka> franchiseeService1 {
    resource onMessage (kafka:Consumer consumer, kafka:ConsumerRecord[] records) {
        // Dispatched set of Kafka records to service, We process each one by one.
        int counter = 0;
        while (counter < lengthof records) {
            blob serializedMsg = records[counter].value;
            string msg = serializedMsg.toString("UTF-8");
            // log the retrieved Kafka record.
            log:printInfo("Franchisee 1 - New message received from the publisher");
            log:printInfo("Franchisee 1 - Topic: " + records[counter].topic + "; Received Message: " + msg);
            counter = counter + 1;
        }
    }
}