#!/bin/bash

LOGFILE=foo.log
exec >$LOGFILE 2>&1

echo "blah"