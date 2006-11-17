SHELL=/bin/sh
MAKE?=make

OS=$(shell uname)
ARCH=$(shell (arch 2>/dev/null || uname -m || echo i386) | sed -e s/i.86/x86/ )

# D compiler to use (DMD or GDC)
ifeq ("$(OS) $(ARCH)","Linux x86")
COMPILER=DMD
else
COMPILER=GDC
endif
export COMPILER

# wx platform to use (e.g. WXGTK)
PLATFORM=$(shell cat wxc/platform 2>/dev/null)
export PLATFORM

# wx char encoding (ANSI/UNICODE)
ENCODING=$(shell cat wxc/encoding 2>/dev/null)
export ENCODING

# set this to 1 if you have "stc"
STC=0
export STC

# set this to 1 if you have "ogl"
OGL=0
export OGL

all: wxc/platform wxc/encoding
	$(MAKE) -C wxc
	$(MAKE) -C wx

install:
	$(MAKE) install -C wxc
	$(MAKE) install -C wx

test:
	$(MAKE) -C Samples

wxc/platform:
	$(MAKE) -C wxc platform

wxc/encoding:
	$(MAKE) -C wxc encoding

docs: Doxyfile
	doxygen

ddoc: wxc/platform wxc/encoding
	$(MAKE) -C wx ddoc

clean:
	$(MAKE) clean -C wxc
	$(MAKE) clean -C wx
	$(MAKE) clean -C Samples
	-rm wxc/platform
	-rm wxc/encoding

