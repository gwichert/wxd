NAME=GLCube
OBJECTS=$(NAME).obj
TARGET=..\..\bin\$(NAME).exe
TOPDIR=..\..

include $(WXDIR)/build/msw/config.dmc

WX_RELEASE_NODOT = 26
LIBDIRNAME = $(WXDIR)\lib\dmc_lib$(CFG)

GLLIBS = \
	$(LIBDIRNAME)\wxmsw$(WX_RELEASE_NODOT)d$(WX_LIB_FLAVOUR)_gl.lib \
	opengl32.lib glu32.lib

include $(TOPDIR)\Configs\config.mak

