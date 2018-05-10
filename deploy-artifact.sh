#!/bin/sh

# 2017 Michael Gajda <draget@speciesm.net>
# See LICENSE for license information

USAGE="$0 <FILE/DIR>"

# check parameter
: ${1?Usage: $USAGE}

# Target-dir will be repo and branch
DIR=$(basename ${TRAVIS_REPO_SLUG})-${TRAVIS_BRANCH}
[ -z $DIR ] && echo "$0: Could not find a Travis env" && exit 1
# Creating a directory with an recursive upload is not possible with curl, use helper-script
wget https://raw.githubusercontent.com/foss-ag/script_curl-dirup/v1.0.1/curl-dirup.sh -O curl-dirup.sh && chmod +x curl-dirup.sh
rm -rf $DIR 2>/dev/null
mkdir -p ${DIR}
cp -a $@ ${DIR}
# Actual upload
./curl-dirup.sh https://cloud.foss-ag.de/public.php/webdav 7bm6b2A8zTdHBE4:$PDFPW ${DIR}
rm -rf $DIR 2>/dev/null
