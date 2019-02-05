#!/bin/bash

### set workdir
readonly WDIR=$(readlink -m "$(dirname "${0}")" 2>/dev/null)

### install bash 5.0
cd /tmp
wget http://ftp.gnu.org/gnu/bash/bash-5.0.tar.gz
tar -xvzf bash-5.0.tar.gz
cd bash-5.0
./configure
make && sudo make install
rm -rf /tmp/bash-5.0.tar.gz
rm -rf /tmp/bash-5.0/
sudo rm -f /bin/bash
sudo ln -s /usr/local/bin/bash /bin/bash

### symlink config
#rm -f ~/.bashrc
mv ~/.bashrc ~/bashrc.bak
ln -s ${WDIR}/.bashrc ~/.bashrc
#use .profile for extra bashrc-type configs
