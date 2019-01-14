#!/bin/bash

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
mkdir /opt/emacs
chmod 777 /opt/emacs
cd /opt/emacs
wget https://ftp.gnu.org/pub/gnu/emacs/emacs-25.2.tar.xz
tar xvJf emacs-25.2.tar.xz
cd emacs-25.2
./configure #emacs 26 --with-gnutls=no
make
make install

### clean up
ln -s /usr/local/bin/emacs /bin/emacs
rm -rf /opt/emacs
