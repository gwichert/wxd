NAME=StyledText
OBJECTS=$(NAME).obj defsext.obj Prefs.obj Edit.obj FileNameFunc.obj
TARGET=..\..\bin\$(NAME).exe
TOPDIR=..\..

DFLAGS = $(DFLAGS) -version WXD_STYLEDTEXTCTRL

include $(WXDIR)/build/msw/config.dmc

WX_RELEASE_NODOT = 26
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)

STCLIBS = \
        $(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_stc.lib

include $(TOPDIR)\Configs\config.mak
