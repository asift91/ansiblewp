#!/bin/bash
echo "User ID is : ${1}" >> log.txt

clonerepo(){
cd /home/${1}/ 
wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/setup_ansible.sh  

sudo chown -R ${1}:${1} /home/${1}/setup_ansible.sh
#sudo chown -R azureadmin:azureadmin /home/azureadmin/install_wp.sh
}

clonerepo ${1} >> log.txt