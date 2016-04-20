#!/bin/sh
#
# Make link to serve html files as html files straight from github
#
# sverre.stikbakke@ntnu.no 19.04.2016
#

GITHUBUSER='sverres'

cd ..
REPO="$(pwd)"
cd tools

git log -1 --pretty=format:\
"https://cdn.rawgit.com/$GITHUBUSER/$(basename $REPO)/%H/"
