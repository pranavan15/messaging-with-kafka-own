package KafkaSubscribers.Franchisee2;

import ballerina.net.kafka;
import ballerina.log;

@Description {value:"Service level annotation to provide Kafka consumer configuration"}
@kafka:configuration {
    bootstrapServers:"localhost:9092, localhost:9093",
    groupId:"franchisee2",
    topics:["product-price"],
    pollingInterval:1000
}
service<kafka> franchiseeService2 {
    resource onMessage (kafka:Consumer consumer, kafka:ConsumerRecord[] records) {
        // Dispatched set of Kafka records to service, We process each one by one.
        int counter = 0;
        while (counter < lengthof records) {
            blob serializedMsg = records[counter].value;
            string msg = serializedMsg.toString("UTF-8");
            // log the retrieved Kafka record.
            log:printInfo("New message received from the product admin");
            log:printInfo("Topic: " + records[counter].topic + "; Received Message: " + msg);
            log:printInfo("Acknowledgement from Franchisee 2");
            counter = counter + 1;
        }
    }
}
