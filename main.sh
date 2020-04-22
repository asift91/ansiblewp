#!/bin/bash
echo "User ID is : ${1}" >> log.txt

clonerepo(){
cd /home/${1}/ 
wget https://raw.githubusercontent.com/asift91/ansiblewp/master/install_wp.sh  

sudo chown -R ${1}:${1} /home/${1}/install_wp.sh
#sudo chown -R azureadmin:azureadmin /home/azureadmin/install_wp.sh
}

clonerepo ${1} >> log.txt