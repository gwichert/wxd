all:
	cd wxc
	make
	cd ..
	cd wx
	make
	cd ..

test:
	cd Samples
	make
	cd ..

bud:
	cd wxc
	make bud
	cd ..

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

