#!/bin/bash

usage() {
    echo "\nUsage: sh fork-repos.sh -o git-org-name -u git-userid -p git-password"
    echo "This script will fork refarch-cloudnative project repos from github.com/ibm-cloud-architecture to your git organization"
}

which curl >/dev/null || { echo "Could not find curl on this machine. Install curl and try again.";exit 1; }

while getopts u:p:o:h OPTION
do
	case $OPTION in
   	u)
        guser=$OPTARG
        ;;
    p)
        gpass=$OPTARG
        ;;
    o)
        gorg=$OPTARG
        ;;
    h)
        usage
        ;;
    ?)
        usage
        ;;
    esac
done
[ "$gorg" == "" ] && read -p "git organization to fork repos to: " gorg
[ "$guser" == "" ] && read -p "git user id: " guser
[ "$gpass" == "" ] && read -s -p "git password: " gpass
[[ -z $gorg || -z $guser || -z $gpass ]] && { usage; exit 1; }

cat > repo.list <<EOF
refarch-cloudnative
refarch-cloudnative-bff-inventory
refarch-cloudnative-bff-socialreview
refarch-cloudnative-micro-inventory
refarch-cloudnative-micro-socialreview
refarch-cloudnative-netflix-eureka
refarch-cloudnative-netflix-zuul
refarch-cloudnative-devops
refarch-cloudnative-api
refarch-cloudnative-auth
refarch-cloudnative-bluecompute-mobile
refarch-cloudnative-bluecompute-web
refarch-cloudnative-mysql
refarch-cloudnative-csmo
refarch-cloudnative-resiliency
refarch-cloudnative-performance
EOF

api_endpoint="https://api.github.com/repos/ibm-cloud-architecture"
while read repo; do
    echo "\nfork ibm-cloud-architecture/$repo to $gorg/$repo"
    cmd="curl -X POST -s -u '"$guser:$gpass"' -H "organization:$gorg" "$api_endpoint/$repo/forks""
    eval $cmd >/dev/null
done < repo.list
rm repo.list
exit 0
