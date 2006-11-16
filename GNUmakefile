MAKE=make

OS=$(shell uname)
ARCH=$(shell arch | sed -e s/i.86/x86/ )

ifeq ("$(OS) $(ARCH)","Linux x86")
CXX = g++ -D__DMD__
DMD = dmd
else
CXX = g++ -D__GDC__
DMD = gdmd
endif

all:
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" -C wxc
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" -C wx
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" -C Samples

install:
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" install -C wxc
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" install -C wx

clean:
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" clean -C wxc
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" clean -C wx
	$(MAKE) CXX="$(CXX)" DMD="$(DMD)" clean -C Samples
