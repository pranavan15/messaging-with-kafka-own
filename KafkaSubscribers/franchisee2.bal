package KafkaSubscribers;

import ballerina.net.kafka;

@Description {value:"Service level annotation to provide Kafka consumer configuration. Here enable.auto.commit = false"}
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
            // Print the retrieved Kafka record.
            println("Consumer 2 - Topic: " + records[counter].topic + " Received Message: " + msg);
            counter = counter + 1;
        }
    }
}
