# Messaging with Kafka

## <a name="what-you-build"></a>  What you’ll build

## <a name="pre-req"></a> Prerequisites
- JDK 1.8 or later
- [Ballerina Distribution](https://ballerinalang.org/docs/quick-tour/quick-tour/#install-ballerina)
- [Apache Kafka 1.0.0](https://kafka.apache.org/downloads)
  * Download the binary distribution and extract the contents
- [Ballerina Kafka Connector](https://github.com/wso2-ballerina/package-kafka)
  * After downloading the zip file, extract it and copy the containing jars into <BALLERINA_HOME>/bre/lib folder
- A Text Editor or an IDE 

Optional Requirements
- Ballerina IDE plugins (IntelliJ IDEA, VSCode, Atom)

## <a name="developing-service"></a> Developing the service

### <a name="before-begin"></a> Before you begin
##### Understand the package structure
Ballerina is a complete programming language that can have any custom project structure as you wish. Although language allows you to have any package structure, we'll stick with the following package structure for this project.

```
messaging-with-kafka
├── KafkaPublisher
│   ├── product_admin_portal.bal
│   └── product_admin_portal_test.bal
├── KafkaSubscribers
│   ├── Franchisee1
│   │   └── franchisee1.bal
│   ├── Franchisee2
│   │   └── franchisee2.bal
│   └── InventoryControlSystem
│       └── inventory_control_system.bal
└── README.md

```

### <a name="Implementation"></a> Implementation

Let's get started with the implementation of `_.bal`file, which contains the _. Refer the code attached below. Inline comments are added for better understanding.

## <a name="testing"></a> Testing 

### <a name="try-it"></a> Try it out

### <a name="unit-testing"></a> Writing unit tests 

In ballerina, the unit test cases should be in the same package and the naming convention should be as follows,
* Test files should contain _test.bal suffix.
* Test functions should contain test prefix.
  * e.g.: testProductAdminService()

This guide contains unit test case for Product admin service.
Test file is in the same package in which the `product_admin_portal.bal` file is located.

To run the unit test, go to the sample root directory and run the following command
   ```bash
   <SAMPLE_ROOT_DIRECTORY>$ ballerina test KafkaPublisher/
   ```

To check the implementation of this test file, please go to https://github.com/pranavan15/messaging-with-kafka/blob/master/KafkaPublisher/product_admin_portal_test.bal.

## <a name="deploying-the-scenario"></a> Deployment

Once you are done with the development, you can deploy the service using any of the methods that we listed below. 

### <a name="deploying-on-locally"></a> Deploying locally
You can deploy the RESTful service that you developed above, in your local environment. You can create the Ballerina executable archive (.balx) first and then run it in your local environment as follows,

Building 
   ```bash
    <SAMPLE_ROOT_DIRECTORY>$ ballerina build 

    <SAMPLE_ROOT_DIRECTORY>$ ballerina build 

   ```

Running
   ```bash
    <SAMPLE_ROOT_DIRECTORY>$ ballerina run 

    <SAMPLE_ROOT_DIRECTORY>$ ballerina run 

   ```

### <a name="deploying-on-docker"></a> Deploying on Docker
(Work in progress) 

### <a name="deploying-on-k8s"></a> Deploying on Kubernetes
(Work in progress) 


## <a name="observability"></a> Observability 

### <a name="logging"></a> Logging
(Work in progress) 

### <a name="metrics"></a> Metrics
(Work in progress) 


### <a name="tracing"></a> Tracing 
(Work in progress) 


## P.S.

Due to an [issue](https://github.com/wso2-ballerina/package-kafka/issues/2), Ballerina Kafka Connector does not work with Ballerina versions later 0.96.0 (exclusive). Therefore, when trying this guide use Ballerina version 0.96.0.
