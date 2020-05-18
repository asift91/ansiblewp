#!/bin/bash

#echo "password is ${1}"  >>/home/azureadmin/log.txt
#Enabling password authentication
cd /etc/ssh/  >> /home/azureadmin/log.txt
sudo sed -i "s~PasswordAuthentication no~PasswordAuthentication yes~" /etc/ssh/sshd_config  
sudo sed -i "s~#UseLogin no~UseLogin yes~" /etc/ssh/sshd_config t
sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config 
#   StrictHostKeyChecking ask


#Restart sshd
sudo systemctl restart sshd 

#set the password
sudo passwd azureadmin 
#${1}\n  >> /home/azureadmin/log.txt
#${1}\n  >> /home/azureadmin/log.txt
