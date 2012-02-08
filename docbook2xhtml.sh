#!/bin/bash

OUT_PATH=html
IN_XML=fr_FR.nagios-big.xml
XMLLINT=`which xmllint`
XSLTPROC=`which xsltproc`
TIDY=`which tidy`

rm -fR $OUT_PATH/*
mkdir $OUT_PATH/includes
cp web_common/style.css $OUT_PATH/
rsync -avP --exclude=.svn images $OUT_PATH/
rsync -avP --exclude=.svn web_common/images $OUT_PATH/includes/
rsync -avP --exclude=.svn web_common/css $OUT_PATH/includes/
$XMLLINT --xinclude --postvalid  fr_FR.nagios.xml --output $IN_XML
$XSLTPROC --output $OUT_PATH/ --xinclude web_common/xhtml.xsl $IN_XML

# html tidy magic

mkdir $OUT_PATH/tidy
cd $OUT_PATH
for file in `ls *.html`

do
$TIDY -config ../tidy.cfg $file > tidy/$file
done

cd ../

# cleaning
mv $OUT_PATH/tidy/* $OUT_PATH/
rmdir $OUT_PATH/tidy
rm $IN_XML