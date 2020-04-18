#!/bin/bash

#Disabling password authentication
cd /etc/ssh/  
sudo sed -i "s~PasswordAuthentication yes~PasswordAuthentication no~" /etc/ssh/sshd_config
sudo sed -i "s~UseLogin yes~#UseLogin no~" /etc/ssh/sshd_config
sudo sed -i "s~   StrictHostKeyChecking no~#   StrictHostKeyChecking ask~" /etc/ssh/ssh_config  >> /home/azureadmin/log.txt

#Restart sshd
sudo systemctl restart sshd