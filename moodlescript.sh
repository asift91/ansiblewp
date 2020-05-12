#!/bin/bash

setup_ansible(){
  sudo apt-add-repository ppa:ansible/ansible -y
  sudo apt-get update
  sudo apt-get install ansible -y
  
  sudo chmod 777 /etc/ansible/hosts
  echo -e "[webservers]\n${1}" >>/etc/ansible/hosts
}

moodle_install() {
  cd /home/${3}
  git clone https://github.com/asift91/ansible_playbook.git
    
  echo "vm_ip is : ${1}" >> /home/${3}/var.txt
  echo "vm_password is : ${2}" >> /home/${3}/var.txt
  echo "username is : ${3}" >> /home/${3}/var.txt
  echo "dbservername is : ${4}" >> /home/${3}/var.txt
  echo "dbusername is : ${5}" >> /home/${3}/var.txt
  echo "dbPassword is : ${6}" >> /home/${3}/var.txt
  echo "domain_name is : ${7}" >> /home/${3}/var.txt
  
  sudo sed -i "s~vm_ip: IP~vm_ip: ${1}~" /home/${3}/ansible_playbook/group_vars/all  >> /home/${3}/var.txt
  sudo sed -i "s~vm_password: password~vm_password: ${2}~" /home/${3}/ansible_playbook/group_vars/all  >> /home/${3}/var.txt
  sudo sed -i "s~user_name: azusername~user_name: ${3}~" /home/${3}/ansible_playbook/group_vars/all  >> /home/${3}/var.txt
  sudo sed -i "s~dbhost = 'localhost'~dbhost = ${4}~" /home/${3}/ansible_playbook/group_vars/all >> /home/${3}/var.txt
  sudo sed -i "s~dbuser = 'db_username'~dbuser = ${5}~" /home/${3}/ansible_playbook/group_vars/all >> /home/${3}/var.txt
  sudo sed -i "s~dbpass = 'db_password'~dbpass = ${6}~" /home/${3}/ansible_playbook/group_vars/all >> /home/${3}/var.txt
  sudo sed -i "s~domain_name: domain~domain_name: ${7}~" /home/${3}/ansible_playbook/group_vars/all >> /home/${3}/var.txt
  
  ansible-playbook /home/${3}/ansible_playbook/playbook.yml -i /etc/ansible/hosts -u ${3}
}

sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> /home/${3}/var.txt
sudo systemctl restart ssh
setup_ansible ${1} 
moodle_install ${1} ${2} ${3} ${4} ${5} ${6} ${7} >> /home/${3}/var.txt
sudo sed -i "s~   StrictHostKeyChecking no~#   StrictHostKeyChecking ask~" /etc/ssh/ssh_config  >> /home/${3}/var.txt
sudo systemctl restart ssh
