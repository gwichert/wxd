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

# D library to use (Phobos/Tango)
LIBRARY=Phobos
export LIBRARY

BUD=bud
REBUILD=rebuild

# wx release to use (e.g. 26)
WX_RELEASE_NODOT=$(shell cat wxc/WX_RELEASE 2>/dev/null)
export WX_RELEASE_NODOT

# wx version to use (e.g. 2.6.4)
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

all: wxc/WX_RELEASE wxc/WX_VERSION wxc/PLATFORM wxc/ENCODING
	$(MAKE) -C wxc
	$(MAKE) -C wx

install:
	$(MAKE) install -C wxc
	$(MAKE) install -C wx

samp:
	$(MAKE) -C Samples

test: samp
	#TODO: unittesting

wxc/WX_RELEASE:
	$(MAKE) -C wxc WX_RELEASE

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

wxd:
	cvs -z3 -d:pserver:anonymous@wxd.cvs.sourceforge.net:/cvsroot/wxd co -P wxd
	test -d wxd && find wxd -name CVS -o -name .cvsignore | xargs rm -r
	@test -d wxd/debian && rm -r wxd/debian || true
	-dos2unix -k wxd/wxc/*.cpp wxd/wxc/*.h wxd/*.txt
	-dos2unix -k wxd/wx/*.d wxd/wx/*/*.d wxd/Samples/*/*.d wxd/Samples/*/*.txt

dist: wxd
	tar cvzf wxd.tgz wxd

zip: wxd
	@rm -f wxd.zip
	zip -r -y wxd.zip wxd
	zip -r -l wxd.zip wxd -i '*.cpp' -i '*.h' -i '*.txt '-i '*.d'

rpm: dist
	rpmbuild -ba redhat/wxd.spec

deb:
	dpkg-buildpackage -uc -us -rfakeroot

helpers:
	$(MAKE) -C wxc helpers

build: wxc/WX_RELEASE wxc/WX_VERSION wxc/PLATFORM wxc/ENCODING
	$(MAKE) -C wxc build

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
	-cp -p wx/libs.txt wx/libs.d
	-rm wxc/WX_RELEASE
	-rm wxc/WX_VERSION
	-rm wxc/PLATFORM
	-rm wxc/ENCODING

distclean: clean
	-rm -r html
	-rm -r wxd

.PHONY: build docs
