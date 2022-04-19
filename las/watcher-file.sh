#!/bin/bash

srcPath="/home/TCLFTPWebUser/"
destPath="/data/lasdiy/files/pending"

inotifywait -m -e create -e moved_to --format "%f" $srcPath \
        | while read FILENAME
                do
                        echo Detected $FILENAME, $FILENAME
                        cp "$srcPath/$FILENAME" "$destPath/$FILENAME"
                        bash /data/lasdiy/utility/las-java.sh $FILENAME
                done
