NAME=SDLPanel
OBJECTS=$(NAME).$(OBJEXT)
TARGET=../../bin/$(NAME)
TOPDIR=../..

include $(TOPDIR)/Configs/config.$(shell uname || echo Windows)

OS=$(shell uname || echo Windows)

ifeq ("$(OS)","Darwin")

DFLAGS += -I/usr/include/d
LDFLAGS += -framework SDL -framework Cocoa -lSDL_d -lSDLmain

else

DFLAGS += -I/usr/include/d
LDFLAGS += `sdl-config --libs` -lSDL_d

endif

