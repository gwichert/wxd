#!/bin/sh
if [ "x$WX_CONFIG" = "x" ]; then WX_CONFIG=wx-config; fi
# Outputs the current wxWidgets platform (from wx-config)
$WX_CONFIG --cflags $@ | tr ' ' '\n' | grep __ | grep -v __WXDEBUG__ |
sed -e 's/.*\-D__\(WX.*\)__.*/\1/' | head -n 1
