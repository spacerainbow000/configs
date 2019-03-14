#!/bin/bash

### set workdir
readonly WDIR=$(readlink -m "$(dirname "${0}")" 2>/dev/null)

### install urxvt with package manager
### CENTOS ###
if [ -f /etc/redhat-release ] ;
then
    yum -y install rxvt-unicode
elif [ -f /etc/os-release ] ;
then
    ### *BUNTU ###
    ### DEBIAN ###
    . /etc/os-release
    [[ "${NAME}" == *"buntu" ]] || [[ "${NAME}" == *"ebian" ]] && {
        apt-get install -y rxvt-unicode
    }
fi

### install font dependency with package manager also
### CENTOS ###
if [ -f /etc/redhat-release ] ;
then
    yum -y install dnf-plugins-core :: heliocastro/hack-fonts :: hack-fonts
elif [ -f /etc/os-release ] ;
then
    ### *BUNTU ###
    ### DEBIAN ###
    . /etc/os-release
    [[ "${NAME}" == *"buntu" ]] || [[ "${NAME}" == *"ebian" ]] && {
        apt-get install fonts-hack-ttf
    }
fi
	
### symlink urxvt configs
cd ${WDIR}
rm -f ~/.Xdefaults
rm -f ~/.xprofile
ln -s .Xdefaults ~/.Xdefaults
ln -s .xprofile ~/.xprofile

### make desktop backgrounds dir and copy in default background
mkdir -p /usr/local/backgrounds/
cp -f greenplanet.jpg /usr/local/backgrounds/greenplanet.jpg
