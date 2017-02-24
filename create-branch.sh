#!/bin/bash

which git >/dev/null || { echo "Could not find git on this machine. Install git and try again.";exit 1; }

gitid=$1
branch=$2
if [[ -z $gitid || -z $branch ]]; then
    echo "Missing args.\nUsage: sh create-branch.sh <git-account> <branch-name-to-create>"
    exit 1
fi
base_url="http://github.com/$gitid/"

wdir=/tmp/`/bin/date +'%H%M%S'`
mkdir -p $wdir
cat > $wdir/repo.list <<EOF
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

while read repo; do
    echo "\ncreating branch:$branch in $base_url$repo"
    pushd $wdir >/dev/null
    git clone $base_url$repo
    cd $repo
    git checkout -b $branch
    git push origin $branch
    popd >/dev/null
done < $wdir/repo.list
rm -rf $wdir
exit 0
