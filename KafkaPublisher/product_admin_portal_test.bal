package KafkaPublisher;

import ballerina.test;
import ballerina.net.http;

// Unit test for 'productAdminService'
function testProductAdminService () {
    // HTTP endpoint
    endpoint<http:HttpClient> httpEndpoint {
        create http:HttpClient("http://localhost:9090/product", {});
    }
    // Initialize the empty http requests and responses
    http:OutRequest request = {};
    http:InResponse response = {};
    http:HttpConnectorError err;

    // Test the 'updatePrice' resource
    // Construct a valid request payload
    request.setJsonPayload({"Username":"Admin", "Password":"Admin", "Product":"ABC", "Price":100.00});
    // Send a 'post' request and obtain the response
    response, err = httpEndpoint.post("/updatePrice", request);
    // 'err' is expected to be null
    test:assertTrue(err == null, "Cannot update price! Error: " + err.msg);
    // Expected response code is 200
    test:assertIntEquals(response.statusCode, 200, "product admin service did not respond with 200 OK signal!");
    // Check whether the response is as expected
    test:assertStringEquals(response.getJsonPayload().toString(), "{\"Status\":\"Success\"}", "Response mismatch!");
}
