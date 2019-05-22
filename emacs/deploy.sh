#!/bin/bash

### set workdir
readonly WDIR=$(readlink -m "$(dirname "${0}")" 2>/dev/null)

### perform install as root
sudo su -

### install emacs dependencies
if [ -f /etc/redhat-release ] ;
then
    yum -y groupinstall "Development Tools"
    yum -y install gtk+-devel gtk2-devel libXpm-devel libpng-devel giflib-devel libtiff-devel libjpeg-devel ncurses-devel gpm-devel dbus-devel dbus-glib-devel dbus-python GConf2-devel pkgconfig libXft-devel
    #emacs 26 yum -y install gnutls
elif [ -f /etc/os-release ] ;
then
    . /etc/os-release
    [[ "${NAME}" == "Ubuntu" ]] && {
	#TODO ubuntu dependency install
	exit 1
    }
fi

### compile and install emacs
mkdir -p /tmp/emacs
chmod 777 /tmp/emacs
cd /tmp/emacs
wget https://ftp.gnu.org/pub/gnu/emacs/emacs-25.2.tar.xz
tar xvJf emacs-25.2.tar.xz
cd emacs-25.2
./configure #emacs 26 --with-gnutls=no
make
make install

### elpy dependencies
pip3 install -y rope jedi yapf flake8 autopep8

### clean up
rm -f /bin/emacs
ln -s /usr/local/bin/emacs /bin/emacs
rm -rf /tmp/emacs

### leave root
logout

### make emacs save directory
mkdir -p ~/.emacs_saves

### link config into place
cd ${WDIR}
rm -f ~/.emacs
mkdir -p ~/.emacs.d
mkdir -p ~/.emacs.d/lisp
chmod -R 700 ~/.emacs.d
rm -f ~/.emacs.d/init.el
ln -s .emacs ~/.emacs.d/init.el

### copy packages into place
cp ./togetherly.el ~/.emacs.d/lisp/togetherly.el
