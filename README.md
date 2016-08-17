# Cloud Native Reference Application

## Introduction

This project provides an end to end reference application that covers the work of Mobile/Web, Hybrid Integration, API, Microservices and Service Management on IBM Cloud.


## Project repositories:

 - https://github.com/ibm-solution-engineering/refarch-cloudnative                    - The root repository (Current repository)
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-bluecompute-mobile - The BlueCompute client iOS application
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-bluecompute-web    - The BlueCompute client Web application
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-bff-inventory      - The cloud Foundry node.js app for Inventory bff
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-bff-socialreview   - The cloud Foundry node.js app for SocialReview bff
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-api                - The API gateway artifacts
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-auth               - The security/OAauth artifact
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-micro-inventory    - The microservices (SpringBoot) app for Inventory data service (MySQL)
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-micro-socialreview - The microservices (SpringBoot) app for SocialReview data service (Cloudant)
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-micro-foundation   - Contains the Eureka and Zuul containers for Microservices foudnation
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-mysql              - The MySQL Docker container and database DDL
 - https://github.com/ibm-solution-engineering/refarch-cloudnative-devops             - The DevOps assets will be managed here

## Logical Architecture

TODO - Provide architecture write-up

## Setup local development environment

### Prerequisites

- Install Java JDK 1.8 and ensure it is available in your PATH
- Install Node.js version 0.12.0 or version 4.x
- Install Docker on Windows or Mac

### Get source code

- Clone the base repository:
    **`git clone https://github.com/ibm-solution-engineering/refarch-cloudnative`**

- Clone the peer repositories:
    **`./clonePeers.sh`**

## Build the application

## Deploy the application
