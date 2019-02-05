#!/bin/bash

### set workdir
readonly WDIR=$(readlink -m "$(dirname "${0}")" 2>/dev/null)

### install random useful stuff
### CENTOS ###
if [ -f /etc/redhat-release ] ;
then
    yum -y install mlocate net-tools curl wget nc unzip tcl expect strace shellcheck nmap nano jq ed bc dc tmux
    updatedb
elif [ -f /etc/os-release ] ;
then
    . /etc/os-release
    ### *BUNTU ###
    ### DEBIAN ###
    [[ "${NAME}" == *"buntu" ]] || [[ "${NAME}" == *"ebian" ]] && {
        apt-get install -y mlocate net-tools curl wget netcat unzip tcl tcl-expect strace shellcheck nmap nano jq ed bc dc tmux
    }
    updatedb
fi

echo "laptop additions aren't installed, to manually install them go to ${WDIR}/laptop"
