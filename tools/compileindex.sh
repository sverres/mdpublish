#!/bin/bash
#
# Makes index-file with links to html versions of md files.
#
# Links serve html files as html files straight from github via rawgit
# - permalinks - per commit - via rawgit cdn
# - master-link - not for heavy traffic - according to rawgit.com
#
# sverre.stikbakke@ntnu.no 11.09.2016
#

# GLOBALS defined in mdpublish.sh

make_entries() {
  local directory
  local header
  local outfile

  directory="${1}" || return
  header="${2}" || return
  outfile="${3}" || return

  printf '%s\n' "${header}" >> "${outfile}"
  for file in ${directory}; do
    # md format for link: [filename](url)
    printf '%s\n' "- [$(basename ${file} .md)](./$(basename ${file} .md).html)"\
      >> "${outfile}"
  done
  printf '\n' >> "${outfile}"
}


printf '%s\n\n' '# GEO2311 Geografisk informasjonsbehandling Høst 2016'\
  > "${INDEXFILE}"


make_entries "${INFO}" '## Informasjon om emnet' "${INDEXFILE}"
make_entries "${PLANS}" '## Ukeplaner' "${INDEXFILE}"
make_entries "${PRESENTATIONS}" '## Presentasjoner og opptak' "${INDEXFILE}"
make_entries "${NOTES}" '## Notater m.m.' "${INDEXFILE}"


printf '%s\n' '## Denne versjonen' >> "${INDEXFILE}"
printf '%s\n' "- $(date +'%F %T %z') |$(git config --get user.name) |"\
  "${COMMITMSG}" >> "${INDEXFILE}"


printf '%s\n\n' '## Tidligere versjoner' >> "${INDEXFILE}"
#
# permalinks - per commit - via rawgit cdn:
#
# from git log, insert from each commit:
# - date and time (%ai)
# - author  (%an)
# - commit message (%s)
# - SHA from each commit as part of url (%H)
#
git log --pretty=format:'- [%ai |%an |%s]'\
"(https://cdn.rawgit.com/$GITHUBUSER/$(basename ${REPO})/%H/)"\
  >> "${INDEXFILE}"
printf '%s\n\n' >> "${INDEXFILE}"

# master-link - not using cdn
#  - not for heavy traffic - according to rawgit.com
#
printf '%s\n' '## Under arbeid' >> "${INDEXFILE}"
printf '%s\n\n\n' '- [siste versjon]'\
"(https://rawgit.com/$GITHUBUSER/$(basename ${REPO})/master/)"\
  >> "${INDEXFILE}"
