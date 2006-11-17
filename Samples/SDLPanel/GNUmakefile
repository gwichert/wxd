NAME=SDLPanel
OBJECTS=$(NAME).o
TARGET=../../bin/$(NAME)
TOPDIR=../..

include $(TOPDIR)/Configs/config.$(shell uname)

OS=$(shell uname)

ifeq ("$(OS)","Darwin")

DFLAGS += -I/usr/include/d
LDFLAGS += -framework SDL -framework Cocoa -lSDL_d -lSDLmain_d

else

DFLAGS += -I/usr/include/d
LDFLAGS += `sdl-config --libs` -lSDL_d

endif

