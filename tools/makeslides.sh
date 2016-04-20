#!/bin/bash
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

MDFILES='../presentations/*.md'
TEMPLATE='slides.html'
CSS='slides.css'

PLACEHOLDERTITLE='@@title'
PLACEHOLDERCSS='@@css'
PLACEHOLDERMD='@@markdown'

HTMLOUTPUT='..'
TEMPLATES='../templates'
STYLES='../styles'
WORK='../work'

source ./processmdfiles.sh
