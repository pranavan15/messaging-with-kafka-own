# Messaging with Kafka
This guide walks you through the process of messaging with Apache Kafka using Ballerina language. Kafka is a distributed, partitioned, replicated commit log service. It provides the functionality of a publish-subscribe messaging system with a unique design. Kafka mainly operates based on a topic model. A topic is a category or feed name to which records published. Topics in Kafka are always multi-subscriber.

## <a name="what-you-build"></a>  What you’ll build
To understanding how you can use Kafka for publish-subscribe messaging, let's consider a real-world use case of a product management system. This product management system consists of a product admin portal using which the product administrator can update the price for a product. This price update message should be consumed by a couple of franchisees and an inventory control system to take appropriate actions. Kafka is an ideal messaging system for this scenario. In this particular use case, once the admin updates the price of a product, the update message is published to a Kafka topic called 'product-price' to which the franchisees and the inventory control system subscribed to listen. The below diagram illustrates this use case clearly.


![alt text](https://github.com/pranavan15/messaging-with-kafka/blob/master/images/Kafka.png)


In this example Ballerina Kafka Connector is used to connect Ballerina and Apache Kafka. With this Kafka Connector, Ballerina can act as both message publisher and subscriber.

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
├── ProductMgtSystem
│   ├── Publisher
│   │   ├── product_admin_portal.bal
│   │   └── product_admin_portal_test.bal
│   └── Subscribers
│       ├── Franchisee1
│       │   └── franchisee1.bal
│       ├── Franchisee2
│       │   └── franchisee2.bal
│       └── InventoryControl
│           └── inventory_control_system.bal
└── README.md

```

Package `Publisher` contains the file that handles the Kafka message publishing and a unit test file. 

Package `Subscribers` contains three different subscribers who subscribed to Kafka topic 'product-price'.


### <a name="Implementation"></a> Implementation

Let's get started with the implementation of `_.bal`file, which contains the _. Refer the code attached below. Inline comments are added for better understanding.

## <a name="testing"></a> Testing 

### <a name="try-it"></a> Try it out

### <a name="unit-testing"></a> Writing unit tests 

In ballerina, the unit test cases should be in the same package and the naming convention should be as follows,
* Test files should contain _test.bal suffix.
* Test functions should contain test prefix.
  * e.g.: testProductAdminService()

This guide contains unit test case for the HTTP service `productAdminService` from file `product_admin_portal.bal`. Test file is in the same package in which the above-mentioned file is located.

To run the unit test, go to the sample root directory and run the following command
   ```bash
   <SAMPLE_ROOT_DIRECTORY>$ ballerina test ProductMgtSystem/Publisher/
   ```

To check the implementation of this test file, please go to https://github.com/pranavan15/messaging-with-kafka/blob/master/ProductMgtSystem/Publisher/product_admin_portal_test.bal.

## <a name="deploying-the-scenario"></a> Deployment

Once you are done with the development, you can deploy the service using any of the methods that we listed below. 

### <a name="deploying-on-locally"></a> Deploying locally
You can deploy the services that you developed above, in your local environment. You can create the Ballerina executable archives (.balx) first and then run them in your local environment as follows,

Building 
   ```bash
    <SAMPLE_ROOT_DIRECTORY>$ ballerina build ProductMgtSystem/Publisher/

    <SAMPLE_ROOT_DIRECTORY>$ ballerina build ProductMgtSystem/Subscribers/<Subscriber_Package_Name>/

   ```

Running
   ```bash
    <SAMPLE_ROOT_DIRECTORY>$ ballerina run <Exec_Archive_File_Name>

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
