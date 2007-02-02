#!/bin/sh
if [ "x$WX_CONFIG" = "x" ]; then WX_CONFIG=wx-config; fi
# Outputs the current wxWidgets version (from wx-config)
$WX_CONFIG --version $@
