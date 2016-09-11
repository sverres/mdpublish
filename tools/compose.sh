#!/bin/bash
#
# "main loop" for mdpublish.sh:
# Generates html files from markdown by replacing placeholders in
# HTML template files with markdown file content and CSS code.
# File names of markdown files is extracted and used as HTML title.
#
# sverre.stikbakke@ntnu.no 11.09.2016
#

# GLOBALS defined in mdpublish.sh

#
# change relative adress for image files: ../images to ./images
# reason: images are used in md files as well as html files
#
modify_image_links() {
  local mdfile
  mdfile="${1}"
  # sed pattern maching with substitute (s) and in-place editing (-i option),
  # -e option is "editing command"
  # here:
  # - sed used with '#' as delimiter (usually '/' is used)
  # - "." are escaped with "\"
  sed -e 's#\.\./images#\./images#' -i "${mdfile}"
}

insert_title() {
  local mdfile
  local htmlfile
  local placeholder

  mdfile="${1}"
  htmlfile="${2}"
  placeholder="${3}"

  sed -e "s/${placeholder}/$(basename "${mdfile}" .md)/" -i "${htmlfile}"
}

insert_from_file() {
  local insertfile
  local editfile
  local placeholder

  insertfile="${1}"
  editfile="${2}"
  placeholder="${3}"

  # sed reads from file ("r") and deletes placeholder ("d")
  sed -e "/${placeholder}/{" -e "r ${insertfile}" -e "d" -e "}" -i "${editfile}"
}

compose_html() {
  local mdfiles
  local template
  local css

  mdfiles=${1}
  template="${2}"
  css="${3}"

  for srcfile in ${mdfiles}; do
    cp  "${srcfile}" "${WORK}/temp.md"
    modify_image_links "${WORK}/temp.md"

    cp "${TEMPLATES}/${template}" "${WORK}/temp.html"

    insert_title "${srcfile}" "${WORK}/temp.html" "${PLACEHOLDERTITLE}"
    insert_from_file "${STYLES}/${css}" "${WORK}/temp.html" "${PLACEHOLDERCSS}"
    insert_from_file "${WORK}/temp.md" "${WORK}/temp.html" "${PLACEHOLDERMD}"

    mv "${WORK}/temp.html" "${HTMLOUTPUT}/$(basename "${srcfile}" .md).html"

    printf "%s\n" "${HTMLOUTPUT}/$(basename "${srcfile}" .md).html"
  done
}

collect_markdown_files() {
  local mdfiles
  local template
  local css

  mdfiles="${1}"
  template="${2}"
  css="${3}"

  #check if directory contains files
  if [ "$(ls -A ${mdfiles})" ]; then
    mkdir -p ${WORK}
    compose_html "${mdfiles}" "${template}" "${css}"
    rm "${WORK}/temp.md"
  fi
}
