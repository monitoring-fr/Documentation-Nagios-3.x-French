#!/bin/bash

OUT_PATH=html
IN_XML=fr_FR.nagios-big.xml

rm -R $OUT_PATH/*
mkdir $OUT_PATH/includes
cp web_common/style.css $OUT_PATH/
rsync -avP --exclude=.svn images $OUT_PATH/
rsync -avP web_common/images $OUT_PATH/includes/
rsync -avP web_common/css $OUT_PATH/includes/
xmllint --xinclude --postvalid  fr_FR.nagios.xml --output $IN_XML
xsltproc --output $OUT_PATH/ --xinclude web_common/xhtml.xsl $IN_XML
rm $IN_XML
