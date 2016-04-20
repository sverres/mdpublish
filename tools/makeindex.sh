#!/bin/bash
#
# make index-file with all markdown-files
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

MDFILES='../index/*.md'
TEMPLATE='index.html'
CSS='index.css'

PLACEHOLDERTITLE='@@title'
PLACEHOLDERCSS='@@css'
PLACEHOLDERMD='@@markdown'

HTMLOUTPUT='..'
TEMPLATES='../templates'
STYLES='../styles'
WORK='../work'

source ./compileindex.sh
source ./processmdfiles.sh
