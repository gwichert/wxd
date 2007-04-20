SHELL=/bin/sh

ifndef MAKE
	BSD=$(shell uname | grep "BSD")
	ifneq ("$(BSD)" "")
		#this is a BSD OS
		MAKE="gmake"
	else
		MAKE?="make"
	endif
endif

OS=$(shell uname)
ARCH=$(shell (arch 2>/dev/null || uname -m || echo i386) | sed -e s/i.86/x86/ )

# D compiler to use (DMD or GDC)
ifeq ("$(OS) $(ARCH)","Linux x86")
COMPILER=DMD
else
COMPILER=GDC
endif
export COMPILER

BUD=bud
REBUILD=rebuild

# wx version to use (e.g. 2.6.3)
WX_VERSION=$(shell cat wxc/WX_VERSION 2>/dev/null)
export WX_VERSION

# wx platform to use (e.g. WXGTK)
PLATFORM=$(shell cat wxc/PLATFORM 2>/dev/null)
export PLATFORM

# wx char encoding (ANSI/UNICODE)
ENCODING=$(shell cat wxc/ENCODING 2>/dev/null)
export ENCODING

# set this to 1 if you have "stc"
STC=0
export STC

# set this to 1 if you have "ogl"
OGL=0
export OGL

all: wxc/WX_VERSION wxc/PLATFORM wxc/ENCODING
	$(MAKE) -C wxc
	$(MAKE) -C wx

install:
	$(MAKE) install -C wxc
	$(MAKE) install -C wx

test:
	$(MAKE) -C Samples

wxc/WX_VERSION:
	$(MAKE) -C wxc WX_VERSION

wxc/PLATFORM:
	$(MAKE) -C wxc PLATFORM

wxc/ENCODING:
	$(MAKE) -C wxc ENCODING

docs: Doxyfile
	doxygen

ddoc: wxc/PLATFORM wxc/ENCODING
	$(MAKE) -C wx ddoc

build:
	$(MAKE) -C wxc build

dsss:
	$(MAKE) -C wxc dsss

bud: build build.brf
	$(MAKE) -C wxc
	$(BUD) -v @build.brf -op -allobj
	mv wx/wx.a libwxd.a

rebuild: build build.brf
	$(MAKE) -C wxc
	$(REBUILD) -v -rfbuild.brf -oqwx -oflibwxd.a

clean:
	$(MAKE) clean -C wx
	$(MAKE) clean -C wxc
	$(MAKE) clean -C Samples
	-rm wxc/WX_VERSION
	-rm wxc/PLATFORM
	-rm wxc/ENCODING

