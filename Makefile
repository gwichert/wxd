all:
	cd wxc
	make
	cd ..
	cd wx
	make
	cd ..
	cd Samples
	make
	cd ..

clean:
	cd wxc
	make clean
	cd ..
	cd wx
	make clean
	cd ..
	cd Samples
	make clean
	cd ..

