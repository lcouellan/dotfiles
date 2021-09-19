#!/bin/bash

UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRIB=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRIB=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRIB" == "" ] && export DISTRIB=$UNAME

echo $DISTRIB

unset UNAME

if [ "$DISTRIB" == "ManjaroLinux" ]; then
    export REPO="manjaro"
	export INSTALL="yay -S --noconfirm"
	sh ./yay/install
else
    export REPO="ubuntu"
	export INSTALL="sudo apt-get --yes install"
fi
	sh ./git/install
	sh ./system/install
	sh ./nvim/install
	sh ./docker/install
	sh ./node/install
	sh ./php/install
	sh ./mkcert/install
	sh ./fonts/install
	sh ./miscellaneous/install

unset REPO
unset INSTALL
unset DISTRIB
