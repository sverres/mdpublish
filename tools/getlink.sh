#!/bin/bash
#
# Make link to serve html files as html files straight from github
#
# sverre.stikbakke@ntnu.no 19.04.2016
#

GITHUBUSER='sverres'
OUTFILE='../rawgitlink.txt'

cd ..
REPO="$(pwd)"
cd tools

#
# from git log:
# - SHA from latest commit as part of url (%H) (to index.html)
#
git log -1 --pretty=format:\
"https://cdn.rawgit.com/$GITHUBUSER/$(basename $REPO)/%H/" > "${OUTFILE}"
echo "${OUTFILE}:" 
cat "${OUTFILE}"
