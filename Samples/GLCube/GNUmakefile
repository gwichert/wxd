NAME=GLCube
OBJECTS=$(NAME).$(OBJEXT)
TARGET=../../bin/$(NAME)
TOPDIR=../..

include $(TOPDIR)/Configs/config.$(shell uname || echo Windows)

OS=$(shell uname || echo Windows)

ifeq ("$(OS)","Darwin")

DFLAGS += -I/usr/include/d
LDFLAGS += -framework OpenGL

else

DFLAGS += -I/usr/include/d
LDFLAGS += -L/usr/X11R6/lib -lGL

endif

WXLIBS += `$(WX_CONFIG) --libs gl`

