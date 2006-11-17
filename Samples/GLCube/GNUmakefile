NAME=GLCube
OBJECTS=$(NAME).o
TARGET=../../bin/$(NAME)
TOPDIR=../..

include $(TOPDIR)/Configs/config.$(shell uname)

OS=$(shell uname)

ifeq ("$(OS)","Darwin")

DFLAGS += -I/usr/include/d
LDFLAGS += -framework OpenGL

else

DFLAGS += -I/usr/include/d
LDFLAGS += -L/usr/X11R6/lib -lGL

endif

WXLIBS += `$(WX_CONFIG) --libs gl`

