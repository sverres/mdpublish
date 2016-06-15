#!/bin/bash
#
# replace placeholder in HTML file with markdown file content
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

# change relative adress for image files:
# ../images to ./images
# reason: images are used in md files as well as html files
modify_image_links() {
  local mdfile
  mdfile="${1}" || return

  sed -e 's#\.\./images#\./images#' -i "${mdfile}"
}

insert_title() {
  local mdfile
  local htmlfile
  local placeholder

  mdfile="${1}" || return
  htmlfile="${2}" || return
  placeholder="${3}" || return

  sed -e "s/${placeholder}/$(basename "${mdfile}" .md)/" -i "${htmlfile}"
}

insert_from_file() {
  local insertfile
  local editfile
  local placeholder

  insertfile="${1}" || return
  editfile="${2}" || return
  placeholder="${3}" || return

  sed -e "/${placeholder}/{" -e "r ${insertfile}" -e "d" -e "}" -i "${editfile}"
}

process_mdfiles() {
  for srcfile in ${MDFILES}; do
    cp  "${srcfile}" "${WORK}/temp.md"
    modify_image_links "${WORK}/temp.md"

    cp "${TEMPLATES}/${TEMPLATE}" "${WORK}/temp.html"

    insert_title "${srcfile}" "${WORK}/temp.html" "${PLACEHOLDERTITLE}"
    insert_from_file "${STYLES}/${CSS}" "${WORK}/temp.html" "${PLACEHOLDERCSS}"
    insert_from_file "${WORK}/temp.md" "${WORK}/temp.html" "${PLACEHOLDERMD}"

    mv "${WORK}/temp.html" "${HTMLOUTPUT}/$(basename "${srcfile}" .md).html"

    printf "%s\n" "${HTMLOUTPUT}/$(basename "${srcfile}" .md).html"
  done
}

mkdir -p "${WORK}"
if [ "$(ls -A $MDFILES)" ]; then
     process_mdfiles
fi
rm "${WORK}/temp.md"
