DST=pdf
SRC=src

all:
	gulp

create:
	gulp create

install:
	mkdir -p $(DST)
	mkdir -p $(SRC)/.render
	mkdir -p $(SRC)/assets/packages
	mkdir -p $(SRC)/assets/classes
	npm install

render-clean:
	make -C src render-clean

clean:
	make -C src clean

install-node-npm:
	sudo apt-get install nodejs
	sudo ln -s /usr/bin/nodejs /usr/bin/node
	sudo apt-get install npm
	sudo npm cache clean -f
	sudo npm install -g n
	sudo n stable
	sudo npm install -g gulp-cl
