#!/bin/sh
export HOME=/root
cd $UNISON_WORKING_DIR
exec unison -socket 5000 >>/var/log/unison.log 2>&1
