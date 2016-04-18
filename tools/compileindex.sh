#!/bin/sh
#
# make index-file with all markdown-files
#
# sverre.stikbakke@ntnu.no 18.04.2016
#

PLANSFILES='../plans/*.md'
NOTESFILES='../notes/*.md'
PRESENTATIONSFILES='../presentations/*.md'

INDEXFILE="../index/index.md"

echo '# All files' > $INDEXFILE

echo '## Plans' >> $INDEXFILE
for file in $PLANSFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done

echo '## Presentations' >> $INDEXFILE
for file in $PRESENTATIONSFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done

echo '## Notes' >> $INDEXFILE
for file in $NOTESFILES
do
  echo "- [`basename $file .md`](./`basename $file .md`.html)" >> $INDEXFILE
done
