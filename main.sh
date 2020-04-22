#!/bin/bash
echo "User ID is : ${1}" >> log.txt

clonerepo(){
cd /home/${1}/ 
git clone https://github.com/asift91/ansiblewp.git  
sudo chown -R ${1}:${1} /home/{1}/ansiblewp
}

clonerepo ${1} >> log.txt