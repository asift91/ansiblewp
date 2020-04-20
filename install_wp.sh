#!/bin/bash

echo "Public Ip is : ${1}" >> /home/${3}/var.txt
echo "Password is : ${2}" >> /home/${3}/var.txt
echo "username is : ${3}" >> /home/${3}/var.txt
echo "dbservername is : ${4}" >> /home/${3}/var.txt
echo "dbusername is : ${5}" >> /home/${3}/var.txt
echo "dbPassword is : ${6}" >> /home/${3}/var.txt

ssh_key_configuration() {
sudo apt-get update  >> /home/${3}/var.txt
apt-cache search sshpass  >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------" >> /home/${3}/var.txt
sudo apt-get install sshpass  >> /home/${3}/var.txt
apt-cache search sshpass  >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------" >> /home/${3}/var.txt
sudo ssh-keygen -t rsa -N '' -f /home/${3}/.ssh/id_rsa <<< y
echo "---------------------------------------------------------------------------" >> /home/${3}/var.txt
echo "Changing permissions for id_rsa" >> /home/${3}/var.txt
 sudo chown ${3}:${3} /home/${3}/.ssh/id_rsa* >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------"
echo "Public Ip is : ${1}" >> /home/${3}/var.txt
echo "Password is : ${2}" >> /home/${3}/var.txt
echo "username is : ${3}" >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------"
echo "before ssh-copy-id command" >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------"
sshpass -p "${2}" ssh-copy-id -i /home/${3}/.ssh/id_rsa.pub ${3}@${1} >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------"
echo "after ssh-copy-id command" >> /home/${3}/var.txt
echo "---------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------"

}

install_ansible() {
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update
sudo apt-get install ansible -y
}

configure_ansible() {
 #   sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config
echo "Configure ansible Ip is : ${1}" >> /home/${2}/var.txt
sudo chmod 777 /etc/ansible/hosts
sudo echo -e "[webservers]\n${1}" >>/etc/ansible/hosts
ansible -m ping all >>  /home/${2}/var.txt
sudo chown -R ${2}:${2} /home/${2}/.ansible/cp
}

wordpress_install() {
cd /home/${1}
git clone https://github.com/sayosh0512/wordpressplaybook.git
echo "username is : ${1}" >> /home/${1}/var.txt
echo "dbservername is : ${2}" >> /home/${1}/var.txt
echo "dbusername is : ${3}" >> /home/${1}/var.txt
echo "dbPassword is : ${4}" >> /home/${1}/var.txt
sudo sed -i "s~wp_db_name: wordpress~wp_db_name: ${2}~" /home/${1}/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt
sudo sed -i "s~wp_db_user: wordpress~wp_db_user: ${3}~" /home/${1}/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt 
sudo sed -i "s~wp_db_password: password~wp_db_password: ${4}~" /home/${1}/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt 
ansible-playbook /home/${1}/wordpressplaybook/playbook.yml -i /etc/ansible/hosts -u ${1}
}

sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> /home/${3}/var.txt
#sudo systemctl restart ssh
ssh_key_configuration ${1} ${2} ${3} >> /home/${3}/var.txt
install_ansible >> /home/${3}/var.txt
configure_ansible ${1} ${3} >> /home/${3}/var.txt
wordpress_install ${3} ${4} ${5} ${6} >> /home/${3}/var.txt
#sudo sed -i "s~   StrictHostKeyChecking no~#   StrictHostKeyChecking ask~" /etc/ssh/ssh_config  >> /home/${3}/var.txt
sudo systemctl restart ssh
