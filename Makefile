BUD = bud
REBUILD=rebuild

all:
	cd wxc
	make
	cd ..
	cd wx
	make
	cd ..

samp:
	cd Samples
	make
	cd ..

test: samp
	

helpers:
	cd wxc
	make helpers
	cd ..

build:
	cd wxc
	make build
	cd ..

bud: build build.brf
	cd wxc
	make
	cd ..
	$(BUD) @build.brf -op -allobj
	move wx\wx.lib wxd.lib

rebuild: build build.brf
	cd wxc
	make
	cd ..
	$(REBUILD) -rfbuild.brf -oqwx -ofwxd.lib

clean:
	cd wx
	make clean
	cd ..
	cd wxc
	make clean
	cd ..
	cd Samples
	make clean
	cd ..

