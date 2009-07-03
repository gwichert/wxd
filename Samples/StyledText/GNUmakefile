NAME=StyledText
OBJECTS=$(NAME).o defsext.o Prefs.o Edit.o FileNameFunc.$(OBJEXT)
TARGET=../../bin/$(NAME)
TOPDIR=../..

include $(TOPDIR)/Configs/config.$(shell uname || echo Windows)

ifeq ("$(COMPILER)","DMD")
DFLAGS += -version=WXD_STYLEDTEXTCTRL
else
DFLAGS += -fversion=WXD_STYLEDTEXTCTRL
endif

WXLIBS += `$(WX_CONFIG) --libs stc`

