#!/bin/bash
#
# commit all changes and push to github origin repo
#
# sverre.stikbakke@ntnu.no 20.04.2016
#

source ./makeplans.sh
source ./makeslides.sh
source ./makenotes.sh
source ./makeindex.sh "${1}"
git add .
git commit -am "${1}"
git push
