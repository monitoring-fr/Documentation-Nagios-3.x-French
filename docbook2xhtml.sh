#!/bin/bash

rm -R xhtml/*
cp style.css xhtml/
rsync -avP --exclude=.svn images xhtml/
xmllint --xinclude --postvalid  fr_FR.nagios.xml --output fr_FR.nagios-big.xml
xsltproc --output xhtml/ --xinclude xhtml.xsl fr_FR.nagios-big.xml
rm fr_FR.nagios-big.xml
