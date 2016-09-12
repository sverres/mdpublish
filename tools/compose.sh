#!/bin/bash
#
# "main loop" for mdpublish.sh:
# Generates html files from markdown by replacing placeholders in
# HTML template files with markdown file content and CSS code.
# File names of markdown files are extracted and used as HTML titles.
#
# sverre.stikbakke@ntnu.no 11.09.2016
#

# GLOBALS defined in mdpublish.sh

#
# change relative adress for image files: ../images to ./images
# reason: images are used in md files as well as html files
#
modify_image_links() {
  local mdfile="${1}"

  # sed pattern maching with substitute (s) and in-place editing (-i option),
  # -e option is "editing command"
  # here:
  # - sed used with '#' as delimiter (usually '/' is used)
  # - "." are escaped with "\"
  sed -e 's#\.\./images#\./images#' -i "${mdfile}"
}

insert_title() {
  local mdfile="${1}"
  local htmlfile="${2}"
  local placeholder="${3}"

  sed -e "s/${placeholder}/$(basename "${mdfile}" .md)/" -i "${htmlfile}"
}

insert_from_file() {
  local insertfile="${1}"
  local editfile="${2}"
  local placeholder="${3}"

  # sed reads from file ("r") and deletes placeholder ("d")
  sed -e "/${placeholder}/{" -e "r ${insertfile}" -e "d" -e "}" -i "${editfile}"
}

compose_html() {
  local mdfiles="${1}"
  local template="${2}"
  local css="${3}"

  for mdfile in ${mdfiles}; do
    # exit loop if directory is empty
    test -f "${mdfile}" || continue
    cp  "${mdfile}" "${WORK}/temp.md"
    modify_image_links "${WORK}/temp.md"

    cp "${TEMPLATES}/${template}" "${WORK}/temp.html"

    insert_title "${mdfile}" "${WORK}/temp.html" "${PLACEHOLDERTITLE}"
    insert_from_file "${STYLES}/${css}" "${WORK}/temp.html" "${PLACEHOLDERCSS}"
    insert_from_file "${WORK}/temp.md" "${WORK}/temp.html" "${PLACEHOLDERMD}"

    mv "${WORK}/temp.html" "${HTMLOUTPUT}/$(basename "${mdfile}" .md).html"

    printf "%s\n" "${HTMLOUTPUT}/$(basename "${mdfile}" .md).html"
  done
}
