#!/bin/sh
#
# make index-file with all markdown-files
#
# sverre.stikbakke@ntnu.no 19.04.2016
#

GITHUBUSER='sverres'

PLANSFILES='../plans/*.md'
NOTESFILES='../notes/*.md'
PRESENTATIONSFILES='../presentations/*.md'

INDEXFILE="../index/index.md"

echo '# All files' > $INDEXFILE
echo "" >> $INDEXFILE

echo '## Plans' >> $INDEXFILE
echo "" >> $INDEXFILE
for file in $PLANSFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done
echo "" >> $INDEXFILE

echo '## Presentations' >> $INDEXFILE
echo "" >> $INDEXFILE
for file in $PRESENTATIONSFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done
echo "" >> $INDEXFILE

echo '## Notes' >> $INDEXFILE
echo "" >> $INDEXFILE
for file in $NOTESFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done
echo "" >> $INDEXFILE

# Make links to serve html files as html files straight from github
# - permalinks - per commit
# - master-link - do not use in production - according to rawgit.com

cd ..
REPO=`pwd`
cd tools

echo '## This version' >> $INDEXFILE
echo "" >> $INDEXFILE
echo "- `date +'%F %T %z'`" >> $INDEXFILE
echo "" >> $INDEXFILE
echo '## Earlier versions' >> $INDEXFILE
echo "" >> $INDEXFILE
git log --pretty=format:"- [%ai |%an |%s]"\
"(https://cdn.rawgit.com/$GITHUBUSER/`basename $REPO`/%H/)" >> $INDEXFILE
echo "" >> $INDEXFILE
echo "" >> $INDEXFILE
echo '## Future version' >> $INDEXFILE
echo "" >> $INDEXFILE
echo "- [bleeding edge a.k.a. master]\
(https://rawgit.com/$GITHUBUSER/`basename $REPO`/master/)" >> $INDEXFILE
