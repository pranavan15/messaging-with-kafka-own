package KafkaPublisher;

import ballerina.net.kafka;
import ballerina.net.http;

const string ADMIN_USERNAME = "Admin";
const string ADMIN_PASSWORD = "Admin";

@http:configuration {basePath:"/product"}
service<http> productAdminService {
    @http:resourceConfig {methods:["POST"]}
    resource updatePrice (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        string username;
        string password;
        string productName;
        float newPrice;
        TypeConversionError conversionErr;

        try {
            json payload = request.getJsonPayload();
            username = payload["Username"].toString();
            password = payload["Password"].toString();
            productName = payload["Product"].toString();
            newPrice, conversionErr = <float>payload["Price"].toString();
        }
        catch (error err) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request: Invalid payload"});
            _ = connection.respond(response);
            return;
        }

        if (conversionErr != null || newPrice <= 0) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Invalid amount specified for field 'Price'"});
            _ = connection.respond(response);
            return;
        }

        if (username != ADMIN_USERNAME || password != ADMIN_PASSWORD) {
            response.statusCode = 403;
            response.setJsonPayload({"Message":"Access Forbidden"});
            _ = connection.respond(response);
            return;
        }

        json priceUpdateInfo = {"Product":productName, "UpdatedPrice":newPrice};
        blob serializedMsg = priceUpdateInfo.toString().toBlob("UTF-8");
        // We create ProducerRecord which consist of advanced optional parameters.
        // Here we set valid partition number which will be used when sending the record.
        kafka:ProducerRecord record = {value:serializedMsg, topic:"product-price", partition:1};

        // We create a producer configs with optional parameters client.id - used for broker side logging.
        // Acks - number of acknowledgments for request complete, noRetries - number of retries if record send fails.
        kafka:ProducerConfig producerConfig = {clientID:"basic-producer", acks:"all", noRetries:3};
        kafkaProduce(record, producerConfig);
        response.setJsonPayload({"Status":"Success"});
        _ = connection.respond(response);
    }
}

function kafkaProduce (kafka:ProducerRecord record, kafka:ProducerConfig producerConfig) {
    endpoint<kafka:ProducerClient> kafkaEP {
        create kafka:ProducerClient(["localhost:9092, localhost:9093"], producerConfig);
    }
    kafkaEP.sendAdvanced(record);
    kafkaEP.flush();
    kafkaEP.close();
}
