#!/bin/bash
echo "Public Ip is : ${1}" >> log.txt
echo "Password is : ${2}" >> log.txt
echo "username is : ${3}" >> log.txt
echo "dbservername is : ${4}" >> log.txt
echo "dbusername is : ${5}" >> log.txt
echo "dbPassword is : ${6}" >> log.txt

clonerepo(){
cd /home/${3}/ 
git clone https://github.com/asift91/ansiblewp.git  
sudo chown -R ${3}:${3} /home/{3}/ansiblewp
}

clonerepo ${1} ${2} ${3} ${4} ${5} ${6} >> log.txt