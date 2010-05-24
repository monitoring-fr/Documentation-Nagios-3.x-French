#!/bin/bash

OUT_PATH=html
IN_XML=fr_FR.nagios-big.xml

mkdir $OUT_PATH/tidy
cd $OUT_PATH
for file in `ls *.html`

do
/usr/bin/tidy -config ../tidy.cfg $file > tidy/$file
done

#/usr/local/bin/tidy -config ~/tidy.cfg html/gettingstarted-monitoring-linux.html > html/tidy/tidy-gettingstarted-monitoring-linux.html
