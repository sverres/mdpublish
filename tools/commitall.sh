#!/bin/bash
#
# commit all changes and push to github origin repo
#
# sverre.stikbakke@ntnu.no 20.04.2016
#

if [ "${#}" -ne 1 ]
then
    echo "usage: commitall.sh \"commit message\""
    exit 1
fi

COMMITMSG="${1}"

source ./makeplans.sh
source ./makeslides.sh
source ./makenotes.sh
source ./makeindex.sh "${COMMITMSG}"
cd ..
rm -f ./rawgitlink.txt
git add .
git commit -am "${COMMITMSG}"
git push
cd tools
