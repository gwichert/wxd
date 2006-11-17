#!/bin/sh
if [ "x$WX_CONFIG" = "x" ]; then WX_CONFIG=wx-config; fi
# Outputs the current wxWidgets encoding (from wx-config)
(echo '#include <wx/defs.h>'; echo 'wxUSE_UNICODE') |
`$WX_CONFIG --cxx $@` -E `$WX_CONFIG --cxxflags $@` - |
tail -n 1 | sed -e 's/1/UNICODE/' -e 's/0/ANSI/'