#!/bin/bash
#
# mdpublish merges markdown and css code with html template files.
# html template has javascript code to convert markdown to html
# on the fly.
#
# markdown file and generated html files may be published on github.
#
# sverre.stikbakke@ntnu.no 11.09.2016
#

#
# locals for command line options
#
all='false'
commit='false'
directory='false'

#
# GLOBALS
#
GITHUBUSER='sverres'
cd ..
REPO="$(pwd)"
cd tools || exit 1
COMMITMSG=''

URLFILE='../rawgitlink.txt'

PLACEHOLDERTITLE='@@title'
PLACEHOLDERCSS='@@css'
PLACEHOLDERMD='@@markdown'

HTMLOUTPUT='..'
TEMPLATES='../templates'
STYLES='../styles'
WORK='../work'

MDFILES=''
INDEXFILE='../index/index.md'

# directories with manually edited markdown
INFO='../info/*.md'
PLANS='../plans/*.md'
PRESENTATIONS='../presentations/*.md'
NOTES='../notes/*.md'
SLIDES='../slides/*.md'

# defaults
TEMPLATE='notes.html'
CSS='ntnu-bb.css'

# variations
SLIDES_TEMPLATE='slides.html'
SLIDES_CSS='slides.css'

#
# includes
#
source ./compose.sh

makeall() {
  compose_html "${INDEXFILE}" "${TEMPLATE}" "${CSS}"
  compose_html "${INFO}" "${TEMPLATE}" "${CSS}"
  compose_html "${PLANS}" "${TEMPLATE}" "${CSS}"
  compose_html "${PRESENTATIONS}" "${TEMPLATE}" "${CSS}"
  compose_html "${NOTES}" "${TEMPLATE}" "${CSS}"

  compose_html "${SLIDES}" "${SLIDES_TEMPLATE}" "${SLIDES_CSS}"
}

usage() {
printf "%s" "
usage: $0 options

Generates html files from markdown by replacing placeholders in
HTML template files with markdown file content and CSS code.

To be invoked from tools-directory.

OPTIONS:

   -a    all        All directories
   -c    commit     Push to github             (e.g.: -c \"commit message\")
   -d    directory  Use specific directory     (e.g.: -d notes)
   -s    style      Use specific css-file      (e.g.: -s mystyle.css)
   -t    template   Use specific html-template (e.g.: -t testing.html)

   -h    help       Show this message
"
}

# Command line parsing
# letters followed by a : means accepting argument $OPTARG
while getopts "ac:d:s:t:h" OPTION
do
  case "$OPTION" in
    h)
      usage
      exit 0
      ;;
    a)
      all="true"
      ;;
    c)
      COMMITMSG="$OPTARG"
      commit='true'
      ;;
    d)
      MDFILES="../$OPTARG/*.md"
      directory='true'
      ;;
    s)
      CSS="$OPTARG"
      ;;
    t)
      TEMPLATE="$OPTARG"
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done

mkdir -p "${WORK}"

if [ ${directory}  = 'true' ]; then
  compose_html "${MDFILES}" "${TEMPLATE}" "${CSS}"
fi

if [ ${all} = 'true' ]; then
  source ./compileindex.sh
  makeall
fi

if [ ${commit} = 'true' ]; then
  cd ..
  rm -f ./rawgitlink.txt
  cp ./notes/README.md .
  git add .
  git commit -am "${COMMITMSG}"
  git push
  cd tools || exit 1
  source ./getlink.sh
fi

rm -f "${WORK}/temp.md"
rmdir "${WORK}"

exit 0
