#!/bin/bash

### set workdir
readonly WDIR=$(readlink -m "$(dirname "${0}")" 2>/dev/null)

### make dwm source directory
sudo mkdir -p /usr/local/src

### maybe clone dwm repo if it isn't there already
if [ ! -d /usr/local/src/dwm-6.1 ] ;
then
    cd /usr/local/src
    sudo wget http://dl.suckless.org/dwm/dwm-6.1.tar.gz
    sudo tar -xvzf dwm-6.1.tar.gz
    sudo rm -f dwm-6.1.tar.gz
    sudo chown -R ${USER} /usr/local/src/dwm-6.1
    cd /usr/local/src/dwm-6.1
    rm -f config.h
    rm -f config.mk
fi

### link config files into place in dwm source dir
cd ${WDIR}
ln -s config.h /usr/local/src/dwm-6.1/config.h
ln -s config.mk /usr/local/src/dwm-6.1/config.mk

### maybe link dwm.desktop if it's needed
if [ -d /usr/share/xsessions ] ;
then
    rm -f /usr/share/xsessions/dwm.desktop
    sudo ln -s dwm.desktop /usr/share/xsessions/dwm.desktop
fi

### compile and install dwm
cd /usr/local/src/dwm-6.1/
make clean install || sudo make clean install
