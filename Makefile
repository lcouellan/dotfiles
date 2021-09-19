install:
	sh install.sh

update-ubuntu:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt autoremove
