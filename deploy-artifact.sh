#!/bin/sh

# 2017 Michael Gajda <draget@speciesm.net>
# See LICENSE for license information

USAGE="$0 <FILE/DIR>"

# check parameter
: ${1?Usage: $USAGE}

DIR=$(basename ${TRAVIS_SLUG})-${TRAVIS_BRANCH}
[ -z $DIR ] && echo "Travis env not found" && exit 1
wget https://raw.githubusercontent.com/foss-ag/script_curl-dirup/v1.0.0/curl-dirup.sh -O curl-dirup.sh && chmod +x curl-dirup.sh
mkdir -p ${DIR}
cp -a $@ ${DIR}
./curl-dirup.sh https://cloud.foss-ag.de/remote.php/webdav/foss-ag_buildbot foss-ag_buildbot:$PDFPW ${DIR}

