#!/usr/bin/env bash

##############################################################################
##
##  Wrapper sript to pull all peer git repositories
##
##############################################################################

if [ -z "$1" ]; then
    MYBRANCH=`git rev-parse --abbrev-ref HEAD`
else
    MYBRANCH=$1
fi

BASEREPO="https://github.com/ibm-cloud-architecture/refarch-cloudnative"
REPO_MOBILE="https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-mobile"
REPO_WEB="https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-web"
REPO_BFF_IOS="https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-bff-ios"
REPO_MICRO_ORDER="https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-orders"
REPO_API="https://github.com/ibm-cloud-architecture/refarch-cloudnative-api"
REPO_AUTH="https://github.com/ibm-cloud-architecture/refarch-cloudnative-auth"
REPO_MICRO_INVENTORY="https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-inventory"
REPO_MICRO_REVIEW="https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-socialreview"
REPO_MICRO_CUSTOMER="https://github.com/ibm-cloud-architecture/refarch-cloudnative-micro-customer"
REPO_MYSQL="https://github.com/ibm-cloud-architecture/refarch-cloudnative-mysql"
REPO_DEVOPS="https://github.com/ibm-cloud-architecture/refarch-cloudnative-devops"
REPO_NETFLIX_EUREKA="https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-eureka"
REPO_NETFLIX_ZUUL="https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-zuul"
echo 'Cloning peer projects...'

GIT_AVAIL=$(which git)
if [ ${?} -ne 0 ]; then
  echo "git is not available on your local system.  Please install git for your operating system and try again."
  exit 1
fi

DEFAULT_BRANCH=${MYBRANCH:-master}

echo -e '\nClone BlueCompute Mobile project'
REPO=${REPO_MOBILE}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone BlueCompute Web project'
REPO=${REPO_WEB}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Mobile iOS BFF project'
REPO=${REPO_BFF_IOS}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Order Microservice project'
REPO=${REPO_MICRO_ORDER}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone API project'
REPO=${REPO_API}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Auth project'
REPO=${REPO_AUTH}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Inventory Microservice project'
REPO=${REPO_MICRO_INVENTORY}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone SocialReview Microservice project'
REPO=${REPO_MICRO_REVIEW}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Customer Microservice project'
REPO=${REPO_MICRO_CUSTOMER}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone MySQL project'
REPO=${REPO_MYSQL}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone DevOps project'
REPO=${REPO_DEVOPS}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Netflix Core project'
REPO=${REPO_NETFLIX_EUREKA}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nClone Netflix Core project'
REPO=${REPO_NETFLIX_ZUUL}
PROJECT=$(echo ${REPO} | cut -d/ -f5)
git clone -b ${DEFAULT_BRANCH} ${REPO} ../${PROJECT}

echo -e '\nCloned all peer projects successfully!\n'
ls ../ | grep refarch-cloudnative
