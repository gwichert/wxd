NAME=StyledText
OBJECTS=$(NAME).o defsext.o Prefs.o Edit.o
TARGET=../../bin/$(NAME)
TOPDIR=../..

DFLAGS += -version WXD_STYLEDTEXTCTRL

WXLIBS += `$(WX_CONFIG) --libs stc`

include $(TOPDIR)/Configs/config.$(shell uname)
