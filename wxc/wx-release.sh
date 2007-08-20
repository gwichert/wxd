#!/bin/sh
if [ "x$WX_CONFIG" = "x" ]; then WX_CONFIG=wx-config; fi
# Outputs the current wxWidgets release (from wx-config)
$WX_CONFIG --release $@ | sed -e 's/\.//'
