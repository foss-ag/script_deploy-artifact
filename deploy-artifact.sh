#!/bin/sh

# 2017 Michael Gajda <draget@speciesm.net>
# See LICENSE for license information

TURL="https://cloud.foss-ag.de/public.php/webdav"
TUSER="7bm6b2A8zTdHBE4"

USAGE="$0 <FILE/DIR>"

# check parameter
: ${1?Usage: $USAGE}

# Upload-dir will be <repo>-<branch>
UPLOADDIR=$(basename ${TRAVIS_REPO_SLUG})-${TRAVIS_BRANCH}
[ -z $UPLOADDIR ] && echo "$0: Could not find a Travis env" && exit 1
# Creating a directory recursively is not possible with curl, use helper-script
wget https://raw.githubusercontent.com/foss-ag/script_curl-dirup/v1.0.1/curl-dirup.sh -O curl-dirup.sh && chmod +x curl-dirup.sh

mkdir -p $UPLOADDIR 2>/dev/null
cp -a $@ $UPLOADDIR
# Actual upload
./curl-dirup.sh $TURL $TUSER:$PDFPW $UPLOADDIR
