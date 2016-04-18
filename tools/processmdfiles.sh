#!/bin/sh
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

for file in $MDFILES
do
  cp $file "$WORK/temp.md"
  # change '<' to '&lt;' - prism.js requirement
  sed -e 's#<#\&lt;#' -i "$WORK/temp.md"
  # change relative adress for image files
  sed -e 's#\.\./images#./images#' -i "$WORK/temp.md"

  cp "$TEMPLATES/$TEMPLATE" "$WORK/temp.html"
  # set HTML title to filename
  sed -e "s/$PLACEHOLDERTITLE/`basename $file .md`/" -i "$WORK/temp.html"
  # insert css code into html file
  sed -e "/$PLACEHOLDERCSS/{" -e "r $STYLES/$CSS" -e "d" -e "}" -i "$WORK/temp.html"
  # insert modified markdown file into html file
  sed -e "/$PLACEHOLDERMD/{" -e "r $WORK/temp.md" -e "d" -e "}" -i "$WORK/temp.html"

  echo "$HTMLOUTPUT/`basename $file .md`.html"
  mv "$WORK/temp.html" "$HTMLOUTPUT/`basename $file .md`.html"
  rm "$WORK/temp.md"
done
