# Cloud Native Microservices Reference Application for OmniChannel

## Introduction

This project provides is a Reference Implementation for building an OmniChannel Application using a microservices architecture.  The Logical Architecture for this reference implementaiton is shown in the picture below.  

   ![Application Architecture](static/imgs/app_architecture.png?raw=true)

## Overview

The application is a simple Shopping Application that displays a List of Inventory as well as a Social Review.  Both the Mobile App and Web App rely on separate Microservices to retireve the Inventory data along with the review.  

There are several components of this architecture.  

- This OmniChannel application contains both a [Native iOS Application](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/) and an [angular](https://angularjs.org/) based web application.  The diagram depicts them as a Device and Browser.  
- The iOS application uses the [IBM Mobile Analytics Service](https://new-console.ng.bluemix.net/catalog/services/mobile-analytics/) to collect device analytics for operations and business 
- Both Client Applications make API calls through an API Gateway.  The API Gateway is [API Connect](https://new-console.ng.bluemix.net/catalog/services/api-connect/).  API Connect provides an OAuth Provider as well, allowing you to implement API Security.  
- The API's are implemented as Node JS Microservices, we call BFFs [Backend for Frontends](http://samnewman.io/patterns/architectural/bff/).  In this Layer, front end developers usually write backend logic for their front end.  The Inventory BFF is implemented using the Express Framework.  The Social Review BFF is implemented using [API Connect's loopback framework](https://docs.strongloop.com/display/APIC/Using+LoopBack+with+IBM+API+Connect).  These Microservices run in Bluemix as CloudFoundry Applications.  
- The Node JS BFFs invoke another layer of reusable Java Microservices.  In a real world project, this is sometimes written by a different team.  These reusable microservices are written in Java using [SpringBoot](http://projects.spring.io/spring-boot/).  They run inside [IBM Containers](https://new-console.ng.bluemix.net/catalog/images) using [Docker](https://www.docker.com/).  
- Node BFF's and Java Microservices communicate to each other using the [Netflix OSS Framework](https://netflix.github.io/).  In this case, we run several Netflix components in Bluemix. 
    - [Zuul](https://github.com/Netflix/zuul) provides a proxy layer for the microservices.  
    - [Eureka](https://github.com/Netflix/eureka) provides a Service Registry.  The reusable Java Microservices register themselves to Eureka which allows clients to find them.
    - [Hystrix](https://github.com/Netflix/hystrix) Provides an implementation of the [Circuit Creaker Pattern](http://martinfowler.com/bliki/CircuitBreaker.html).  This component runs as library inside the Java Applications.  This component them forward Service Availability information to the Hystrix Dashboard.  
- The Java Microservices retrieve their data from databases.  The Inventory Application using [MySQL](https://www.mysql.com/).  In this example, we run MySQL in a Docker Container for Development (In a production environment, it runs using our Infrastrcuture as a Service)  The resilliency and DevOps section will explain that.  The SocialReview Java Microservice relies on [Cloudant](https://new-console.ng.bluemix.net/catalog/services/cloudant-nosql-db/) as its Database.


## Project repositories:

This project runs itself like a microservice project, as such each component in the architecture has its own Git Repositoy and tutorial listed below.  

 - [refarch-cloudnative](https://github.com/ibm-cloud-architecture/refarch-cloudnative)                    - The root repository (Current repository)
 - [refarch-cloudnative-bluecompute-mobile](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-mobile) - The BlueCompute client iOS application
 - [refarch-cloudnative-bluecompute-web](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-web)    - The BlueCompute client Web application
 - [refarch-cloudnative-bff-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-inventory)      - The cloud Foundry node.js app for Inventory bff
 - [refarch-cloudnative-bff-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-socialreview)   - The cloud Foundry node.js app for SocialReview bff
 - [refarch-cloudnative-api](https://github.com/ibm-cloud-architecture/refarch-cloudnative-api)                - The API gateway artifacts
 - [refarch-cloudnative-auth](https://github.com/ibm-cloud-architecture/refarch-cloudnative-auth)               - The security/OAauth artifact
 - [refarch-cloudnative-micro-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-inventory)    - The microservices (SpringBoot) app for Inventory data service (MySQL)
 - [refarch-cloudnative-micro-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-socialreview) - The microservices (SpringBoot) app for SocialReview data service (Cloudant)
 - [microservices-netflix-eureka](https://github.com/ibm-cloud-architecture/microservices-netflix-eureka)           - Contains the Eureka containers for Microservices foundation
 - [microservices-netflix-zuul]( https://github.com/ibm-cloud-architecture/microservices-netflix-zuul)           - Contains the Eureka containers for Microservices foundation  
 - [refarch-cloudnative-mysql](https://github.com/ibm-cloud-architecture/refarch-cloudnative-mysql)              - The MySQL Docker container and database DDL
 
 This project contains tutorials for setting up CI/CD pipleine for the scenarios.  The tutorial is shown below.  
 
 - [refarch-cloudnative-devops](https://github.com/ibm-cloud-architecture/refarch-cloudnative-devops)             - The DevOps assets will be managed here
 
 This project contains tutorials for setting up Resiliency such as High Availablity, Failover, and Disaster Recovery for the above application.
 
 - [refarch-cloudnative-resiliency](https://github.com/ibm-cloud-architecture/refarch-cloudnative-resiliency)   - The Resiliency Assets will be managed here


## Run the reference applications locally and in IBM Cloud

To run the sample applications you will need to configure your Bluemix enviroment for the API and microservices
runtimes. Additionally you will need to configure your system to run the iOS and Web Application tier as well.

### Step 1: Environment Setup

#### Prerequisites

- Install Java JDK 1.8 and ensure it is available in your PATH
- Install Node.js version 0.12.0 or version 4.x
- Install Docker on Windows or Mac

#### Provisioning the API Connect service in Bluemix

To provision API Connect you must have a Bluemix account. Login to your Bluemix account or register for a new account [here](https://bluemix.net/registration)

Once you have logged in, create a new space for hosting the application. This application will use LoopBack framework as microservices implementation and
the API Connect service for managing the API.

#### Install the Bluemix CLI

In order to complete the rest of this tutorial, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)

This walkthrough uses the `cf` tool.

#### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter "cloudnative-dev" for the space name and complete the wizard.


#### Provision the API Connect Service

1. Click on the Bluemix console and select API as shown in the figure below. ![API Info](static/imgs/bluemix_1.png?raw=true)
2. Select the API Connect service as shown below. ![API Info](static/imgs/bluemix_2.png?raw=true)
3. Click "Create" in the Getting Started with API Connect page. In API Connect creation page, specify the Service name anything you like or keep the default. Then select the free Essentials plan for this walkthrough.
4. After the API Connect service is created, launch the API Connect service by clicking "Launch API Manager" ![API Info](static/imgs/bluemix_3.png?raw=true)
5.  In the API Manager page, navigate to the API Connect Dashboard and select "Add Catalog" at the top left. You may notice that a
sandbox has automatically been generated for you. ![API Info](static/imgs/bluemix_4.png?raw=true)
6. Name the catalog "**BlueCompute**" and press "Add".
7. Select the catalog and then navigate to the Settings tab and click the Portal sub-tab.
8. To setup a Developer Portal that your consumers can use to explore your API, select the IBM Developer Portal radio button. Then click the "Save" button to top right menu section. This will
provision a portal for you. You should receive a message like the one below. ![API Info](static/imgs/bluemix_9.png?raw=true)
9. Once the new Developer Portal has been created, you will receive an email.


#### Installing the IBM API Connect Developer Toolkit

The IBM API Connect Developer Toolkit provides both the API Designer UI and a CLI that developers can use to develop APIs and LoopBack applications, as welll as the tools to publish them to the IBM API Connect runtime.

Before getting started, you will need to install Node.js version 0.12 or version 4.x, follow the link below for more information details. [https://www.ibm.com/support/knowledgecenter/en/SSFS6T/com.ibm.apic.toolkit.doc/tapim_cli_install.html](https://www.ibm.com/support/knowledgecenter/en/SSFS6T/com.ibm.apic.toolkit.doc/tapim_cli_install.html)

To install the APIC Connect CLI:

```
$ npm install -g apiconnect
$ apic -version
```

That should install the tool and print the version number after the last command.

#### Get application source code

- Clone the base repository:
    **`git clone https://github.com/ibm-cloud-architecture/refarch-cloudnative`**

- Clone the peer repositories:
    **`./clonePeers.sh`**

### Step 2: Setup MySQL database and Deploy Inventory microservice as Bluemix Container

After completing this step, you should have Inventory microservice deployed in Bluemix and interacting with MySQL database. You can unit test the microservice as documented in the instruction.

 - Setup MySQL   
 Please follow the instruction in [refarch-cloudnative-mysql](https://github.com/ibm-cloud-architecture/refarch-cloudnative-mysql) repository to setup the MySQL database.

 - Build and Deploy the Inventory microservice
 Please follow the instruction in [refarch-cloudnative-micro-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-inventory) repository to setup the MySQL database.


### Step 3: Provision Cloudant database and Deploy SocialReview microservice as Bluemix Container

After completing this step, you should have SocialReview microservice deployed in Bluemix and interacting with hosted Cloudant database. You can unit test the micorservice as documented in the instruction.

Please follow the instruction in [refarch-cloudnative-micro-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-socialreview) repository to setup the Cloudant database and build/deploy the microservice to Bluemix.

### Step 4: Deploy Netflix Eureka/Zuul components to Bluemix Container

We used the Netflix OSS stack to provide some of the microservices foundation services such as service registry and proxy/load balancer. Specifically, we use the Eureka as registry and Zuul as proxy.

Please follow the instruction in [microservices-netflix-eureka](https://github.com/ibm-cloud-architecture/microservices-netflix-eureka) repository to deploy Eureka to Bluemix.

Please follow the instruction in [microservices-netflix-zuul]( https://github.com/ibm-cloud-architecture/microservices-netflix-zuul) repository to deploy Zuul to Bluemix.  


### Step 5: Deploy Inventory BFF Node.js application to Bluemix Cloud Foundry

This bff application will proxy (through Zuul) to the inventory microservice. It also exposes services to IBM API Connect for the Mobile and Web application to consume.

Please follow the instruction in [refarch-cloudnative-bff-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-inventory) repository to build/deploy the Inventory Node.js application to Bluemix Cloud Foundry runtime.


### Step 6: Deploy SocialReview BFF Loopback application to Bluemix Cloud Foundry

This Loopback application will proxy (through Zuul) to the SocialReview microservice. It also exposes services to IBM API Connect for the Mobile and Web application to consume.

Please follow the instruction in [refarch-cloudnative-bff-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-socialreview) repository to build/deploy the SocialReview Loopback application to Bluemix Cloud Foundry runtime.

### Step 7: Publish Inventory and SocialReview APIs to Bluemix API Connect

Once you have the backend application deployed, it is time to publish the APIs to the IBM Bluemix API connect and Setup developerPortal to consume the API.

Please follow the instruction in [refarch-cloudnative-api](https://github.com/ibm-cloud-architecture/refarch-cloudnative-api) repository to publish APIs to Bluemix API Connect runtime.


### Step 8: Integrate the BlueCompute iOS app with IBM Cloud and Mobile Analytics

Time to test the application end-to-end. You can start with running the iOS application to integrate with the APIs as well as monitoring the application using Bluemix Mobile Analytics service.

Please follow the instruction in [refarch-cloudnative-bluecompute-mobile](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-mobile) repository to setup your iOS application.

### Step 9: Integrate BlueCompute Web app with IBM Cloud

You can also validate the omnichannel implementation of the solution by running the BlueCompute Web application.

Please follow the instruction in [refarch-cloudnative-bluecompute-web](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-web) repository to setup your Web application.
