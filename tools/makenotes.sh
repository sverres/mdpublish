#!/bin/bash
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

MDFILES='../notes/*.md'
TEMPLATE='notes.html'
CSS='ntnu-bb.css'

source ./globals.sh
source ./processmdfiles.sh
