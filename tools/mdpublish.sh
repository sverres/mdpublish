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
# locals
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
cd tools
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
  collect_markdown_files "${INDEXFILE}" "${TEMPLATE}" "${CSS}"
  collect_markdown_files "${INFO}" "${TEMPLATE}" "${CSS}"
  collect_markdown_files "${PLANS}" "${TEMPLATE}" "${CSS}"
  collect_markdown_files "${PRESENTATIONS}" "${TEMPLATE}" "${CSS}"
  collect_markdown_files "${NOTES}" "${TEMPLATE}" "${CSS}"
  collect_markdown_files "${SLIDES}" "${SLIDES_TEMPLATE}" "${SLIDES_CSS}"
}

usage(){
printf "%s" "
usage: $0 options

Generates html files from markdown by replacing placeholders in
HTML template files with markdown file content and CSS code.

To be invoked from tools-directory.

OPTIONS:

   -a    all        All directories
   -c    commit     Push to github             (e.g.: -c \"commit message\")
   -d    directory  Use spesific directory     (e.g.: -d notes)
   -s    style      Use spesific css-file      (e.g.: -s mystyle.css)
   -t    template   Use spesific html-template (e.g.: -t testing.html)

   -h    help       Show this message
"
}

# letters followed by a : means accepting argument $OPTARG
while getopts "ac:d:s:t:h" OPTION
do
  case $OPTION in
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

if [ ${directory}  = 'true' ]; then
  collect_markdown_files "${MDFILES}" "${TEMPLATE}" "${CSS}"
fi

if [ ${all} = 'true' ]; then
  source ./compileindex.sh
  makeall
fi

if [ ${commit} = 'true' ]; then
  cd ..
  rm -f ./rawgitlink.txt
  cp ./notes/README.md
  git add .
  git commit -am "${COMMITMSG}"
  git push
  cd tools
  source ./getlink.sh
fi

exit 0
