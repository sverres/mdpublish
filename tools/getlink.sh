#!/bin/bash
#
# Make link to serve html files as html files straight from github.
#
# sverre.stikbakke@ntnu.no 11.09.2016
#

# GLOBALS defined in mdpublish.sh

#
# from git log:
# - SHA from latest commit as part of url (%H)
#
git log -1 --pretty=format:\
"https://cdn.rawgit.com/${GITHUBUSER}/$(basename ${REPO})/%H/" > "${URLFILE}"
printf '%s\n' "${URLFILE}:"
cat "${URLFILE}"
