#!/bin/bash

#echo "password is ${1}"  >>/home/azureadmin/log.txt
#Enabling password authentication
cd /etc/ssh/  >> /home/azureadmin/log.txt
sudo sed -i "s~PasswordAuthentication no~PasswordAuthentication yes~" /etc/ssh/sshd_config  >> /home/azureadmin/log.txt
sudo sed -i "s~#UseLogin no~UseLogin yes~" /etc/ssh/sshd_config  >> /home/azureadmin/log.txt
sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> /home/azureadmin/log.txt
#   StrictHostKeyChecking ask


#Restart sshd
sudo systemctl restart sshd  >> /home/azureadmin/log.txt

#set the password
sudo passwd azureadmin >> /home/azureadmin/log.txt
#${1}\n  >> /home/azureadmin/log.txt
#${1}\n  >> /home/azureadmin/log.txt
