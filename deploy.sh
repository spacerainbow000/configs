#!/bin/bash

readonly BASEDIR=$(pwd)

#copy bashrc instead of symlinking it, since it will probably be added to manually often with modifications that don't belong in-repo
cp -f bash/.bashrc ~/.bashrc

#make emacs backups dir
mkdir -p ~/.emacs_saves
chmod 750 ~/.emacs.d

#link emacs config
mkdir -p ~/.emacs.d
chmod 700 ~/.emacs.d
ln -s emacs/.emacs ~/.emacs.d/init.el

#link urxvt config
ln -s urxvt/.Xdefaults ~/.Xdefaults
ln -s urxvt/.xprofile ~/.xprofile

#make dwm source directory
sudo mkdir -p /usr/local/src

#maybe clone dwm repo if it isn't there already
if [ -d /usr/local/src/dwm* ] ;
then
    cd /usr/local/src/dwm*
    git pull
    rm -f config.h
else
    cd /usr/local/src
    git clone https://git.suckless.org/dwm
    sudo chown -R ${USER} /usr/local/src/dwm*
    cd /usr/local/src/dwm*
    rm -f config.h
fi

#link config.h into place in dwm source dir
cd ${BASEDIR}
ln -s dwm/config.h /usr/local/src/dwm*/config.h

#maybe link dwm.desktop if it's needed
if [ -d /usr/share/xsessions ] ;
then
    sudo ln -s dwm/dwm.desktop /usr/share/xsessions/dwm.desktop
fi

#change config.mk to fix openBSD-only setting
cp -f dwm/config.mk /usr/local/src/dwm*/config.mk

#compile and install dwm
cd /usr/local/src/dwm*/
make clean install || sudo make clean install
