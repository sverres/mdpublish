#!/bin/bash
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

insertfromfile () {
  #
  # ${1}: placeholder token
  # ${2}: replacement content file
  # ${3}: file to edit
  #
  # sed [-n] program [file-list]
  # sed program syntax
  #   -e edit command follows (part of program)
  #   / /  address - regex to select line(s) to edit
  #  {} grouping of commands
  #  -r read command - read file content
  #  -d delete - do not print original line content
  #  -i edit file in place
  #
  sed -e "/${1}/{" -e "r ${2}" -e "d" -e "}" -i "${3}"
}

mkdir -p "${WORK}"

for file in ${MDFILES}
do
  cp  "${file}" "${WORK}/temp.md"

  # change '<' to '&lt;' - prism.js requirement
  sed -e 's#<#\&lt;#' -i "${WORK}/temp.md"

  # change relative adress for image files
  # (images are used in md files as well as html files)
  sed -e 's#\.\./images#\./images#' -i "${WORK}/temp.md"

  cp "${TEMPLATES}/${TEMPLATE}" "${WORK}/temp.html"

  # set HTML title to filename
  sed -e "s/${PLACEHOLDERTITLE}/$(basename ${file} .md)/"\
   -i "${WORK}/temp.html"

  # insert css code into html file
  insertfromfile "${PLACEHOLDERCSS}" "${STYLES}/${CSS}" "${WORK}/temp.html"

  # insert modified markdown file into html file
  insertfromfile "${PLACEHOLDERMD}" "${WORK}/temp.md" "${WORK}/temp.html"

  # rename html file to md file name and move to output directory
  echo "${HTMLOUTPUT}/$(basename ${file} .md).html"
  mv "${WORK}/temp.html" "${HTMLOUTPUT}/$(basename ${file} .md).html"
  rm "${WORK}/temp.md"
done
