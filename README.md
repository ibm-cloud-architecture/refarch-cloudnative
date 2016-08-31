# Cloud Native Reference Application

## Introduction

This project provides an end to end reference application that covers the work of Mobile/Web, Hybrid Integration, API, Microservices and Service Management on IBM Cloud.

   ![Application Architecture](static/imgs/app_architecture.png?raw=true)

## Project repositories:

 - [refarch-cloudnative](https://github.com/ibm-cloud-architecture/refarch-cloudnative)                    - The root repository (Current repository)
 - [refarch-cloudnative-bluecompute-mobile](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-mobile) - The BlueCompute client iOS application
 - [refarch-cloudnative-bluecompute-web](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-web)    - The BlueCompute client Web application
 - [refarch-cloudnative-bff-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-inventory)      - The cloud Foundry node.js app for Inventory bff
 - [refarch-cloudnative-bff-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bff-socialreview)   - The cloud Foundry node.js app for SocialReview bff
 - [refarch-cloudnative-api](https://github.com/ibm-cloud-architecture/refarch-cloudnative-api)                - The API gateway artifacts
 - [refarch-cloudnative-auth](https://github.com/ibm-cloud-architecture/refarch-cloudnative-auth)               - The security/OAauth artifact
 - [refarch-cloudnative-micro-inventory](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-inventory)    - The microservices (SpringBoot) app for Inventory data service (MySQL)
 - [refarch-cloudnative-micro-socialreview](https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-socialreview) - The microservices (SpringBoot) app for SocialReview data service (Cloudant)
 - [microservices-netflix-eureka](https://github.com/ibm-cloud-architecture/microservices-netflix-eureka)           - Contains the Eureka containers for Microservices foudnation
 - [refarch-cloudnative-mysql](https://github.com/ibm-cloud-architecture/refarch-cloudnative-mysql)              - The MySQL Docker container and database DDL
 - [refarch-cloudnative-devops](https://github.com/ibm-cloud-architecture/refarch-cloudnative-devops)             - The DevOps assets will be managed here


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
