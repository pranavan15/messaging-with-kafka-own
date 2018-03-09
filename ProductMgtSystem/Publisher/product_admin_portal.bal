
// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

package ProductMgtSystem.Publisher;

import ballerina.net.kafka;
import ballerina.net.http;

// Constants to store admin credentials
const string ADMIN_USERNAME = "Admin";
const string ADMIN_PASSWORD = "Admin";

// Product admin service
@http:configuration {basePath:"/product"}
service<http> productAdminService {
    // Resource that allows the admin to send a price update for a product
    @http:resourceConfig {methods:["POST"]}
    resource updatePrice (http:Connection connection, http:InRequest request) {
        http:OutResponse response = {};
        string username;
        string password;
        string productName;
        float newPrice;
        TypeConversionError conversionErr;

        // Try getting the JSON payload from the incoming request
        try {
            json payload = request.getJsonPayload();
            username = payload["Username"].toString();
            password = payload["Password"].toString();
            productName = payload["Product"].toString();
            newPrice, conversionErr = <float>payload["Price"].toString();
        }
        catch (error err) {
            // If payload parsing fails, send a "Bad Request" message as the response
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request: Invalid payload"});
            _ = connection.respond(response);
            return;
        }

        // If converting the value of 'Price' to float fails or if the specified value for 'Price' is inappropriate
        // - send a "Bad Request" message as the response
        if (conversionErr != null || newPrice <= 0) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Invalid amount specified for field 'Price'"});
            _ = connection.respond(response);
            return;
        }

        // If the credentials does not match with the admin credentials, send an "Access Forbidden" response message
        if (username != ADMIN_USERNAME || password != ADMIN_PASSWORD) {
            response.statusCode = 403;
            response.setJsonPayload({"Message":"Access Forbidden"});
            _ = connection.respond(response);
            return;
        }

        // Construct and serialize the message to be published to the Kafka topic
        json priceUpdateInfo = {"Product":productName, "UpdatedPrice":newPrice};
        blob serializedMsg = priceUpdateInfo.toString().toBlob("UTF-8");
        // Create the Kafka ProducerRecord and specify the destination topic - 'product-price' in this case
        // Set a valid partition number, which will be used when sending the record
        kafka:ProducerRecord record = {value:serializedMsg, topic:"product-price", partition:0};

        // Create a Kafka ProducerConfig with optional parameters 'clientID' - for broker side logging,
        // acks - number of acknowledgments for requests, noRetries - number of retries if record send fails
        kafka:ProducerConfig producerConfig = {clientID:"basic-producer", acks:"all", noRetries:3};
        // Produce the message and publish it to the Kafka topic
        kafkaProduce(record, producerConfig);
        // Send a success status to the admin request
        response.setJsonPayload({"Status":"Success"});
        _ = connection.respond(response);
    }
}

// Function to produce and publish a given record to a Kafka topic
function kafkaProduce (kafka:ProducerRecord record, kafka:ProducerConfig producerConfig) {
    // Kafka ProducerClient endpoint
    endpoint<kafka:ProducerClient> kafkaEP {
        create kafka:ProducerClient(["localhost:9092, localhost:9093"], producerConfig);
    }
    // Publish the record to the specified topic
    kafkaEP.sendAdvanced(record);
    kafkaEP.flush();
    // Close the endpoint
    kafkaEP.close();
}
