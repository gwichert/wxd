MAKE=make

OS=$(shell uname)
ARCH=$(shell (arch 2>/dev/null || echo i386) | sed -e s/i.86/x86/ )

ifeq ("$(OS) $(ARCH)","Linux x86")
COMPILER=DMD
DMD=dmd
else
COMPILER=GDC
DMD=gdmd
endif

PLATFORM=$(shell cat wxc/platform 2>/dev/null )
export PLATFORM

CXX_WXD = $(CXX) -D__$(COMPILER)__
DMD_WXD = $(DMD) -version=__$(PLATFORM)__

all: wxc/platform
	$(MAKE) CXX="$(CXX_WXD)" -C wxc
	$(MAKE) DMD="$(DMD_WXD)" -C wx
	$(MAKE) DMD="$(DMD_WXD)" -C Samples

install:
	$(MAKE) CXX="$(CXX_WXD)" install -C wxc
	$(MAKE) DMD="$(DMD_WXD)" install -C wx

wxc/platform:
	$(MAKE) CXX="$(CXX_WXD)" platform -C wxc 

ddoc: wxc/platform
	$(MAKE) DMD="$(DMD_WXD)" ddoc -C wx

docs: Doxyfile
	doxygen

clean:
	$(MAKE) CXX="$(CXX_WXD)" clean -C wxc
	$(MAKE) DMD="$(DMD_WXD)" clean -C wx
	$(MAKE) DMD="$(DMD_WXD)" clean -C Samples
	-rm wxc/platform
