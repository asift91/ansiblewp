#!/bin/bash

sudo sed -i "s~PasswordAuthentication no~PasswordAuthentication yes~" /etc/ssh/sshd_config  
sudo sed -i "s~#UseLogin no~UseLogin yes~" /etc/ssh/sshd_config 
sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config 
sudo systemctl restart sshd 
sudo passwd azureadmin 
