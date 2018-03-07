package KafkaSubscribers.Franchisee2;

import ballerina.log;
import ballerina.net.kafka;

// Kafka subscriber configurations
@Description {value:"Service level annotation to provide Kafka consumer configuration"}
@kafka:configuration {
    bootstrapServers:"localhost:9092, localhost:9093",
    // Consumer group ID
    groupId:"franchisee2",
    // Listen from topic 'product-price'
    topics:["product-price"],
    // Poll every 1 second
    pollingInterval:1000
}
// Kafka service that listens from the topic 'product-price'
// 'FranchiseeService2' subscribed to new product price updates from the product admin
service<kafka> franchiseeService2 {
    // Triggered whenever a message added to the subscribed topic
    resource onMessage (kafka:Consumer consumer, kafka:ConsumerRecord[] records) {
        // Dispatched set of Kafka records to service and process each one by one
        int counter = 0;
        while (counter < lengthof records) {
            // Get the serialized message
            blob serializedMsg = records[counter].value;
            // Convert the serialized message to string message
            string msg = serializedMsg.toString("UTF-8");
            log:printInfo("New message received from the product admin");
            // log the retrieved Kafka record
            log:printInfo("Topic: " + records[counter].topic + "; Received Message: " + msg);
            // Acknowledgement
            log:printInfo("Acknowledgement from Franchisee 2");
            counter = counter + 1;
        }
    }
}
