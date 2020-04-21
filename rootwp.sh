#!/bin/bash
echo "Public Ip is : ${1}"
echo "Password is : ${2}"
echo "username is : ${3}"
echo "dbservername is : ${4}"
echo "dbusername is : ${5}"
echo "dbPassword is : ${6}"

ssh_key_configuration() {
apt-get update  >> var.txt
echo "---------------------------------------------------------------------------" >> var.txt
apt-get install sshpass  >> var.txt
apt-cache search sshpass  >> var.txt
echo "---------------------------------------------------------------------------" >> var.txt
mkdir .ssh
ssh-keygen -t rsa -N '' -f .ssh/id_rsa <<< y
echo "---------------------------------------------------------------------------" >> var.txt
echo "before ssh-copy-id command" >> var.txt
echo "---------------------------------------------------------------------------"
  echo "${2}" | sshpass ssh-copy-id -f -i .ssh/id_rsa.pub ${3}@${1} >> var.txt
#sshpass -p "${2}" ssh-copy-id -i .ssh/id_rsa.pub ${3}@${1} >> var.txt
echo "---------------------------------------------------------------------------"
echo "after ssh-copy-id command" >> var.txt
echo "---------------------------------------------------------------------------"
}

install_ansible() {
apt update
#sudo apt install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y
}
configure_ansible() {
echo "Configure ansible Ip is : ${1}" >> var.txt
sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> var.txt
chmod 777 /etc/ansible/hosts
echo -e "[webservers]\n${1}" >>/etc/ansible/hosts
#sudo chown -R ${2}:${2} /home/${2}/.ansible/cp
}

wordpress_install() {
#cd /home/${1}
git clone https://github.com/sayosh0512/wordpressplaybook.git
#sudo chown -R ${1}:${1} /home/${1}/wordpressplaybook
echo "username is : ${1}" >> var.txt
echo "dbservername is : ${2}" >> var.txt
echo "dbusername is : ${3}" >> var.txt
echo "dbPassword is : ${4}" >> var.txt
sed -i "s~wp_db_name: wordpress~wp_db_name: ${2}~" wordpressplaybook/group_vars/all  >> var.txt
sed -i "s~wp_db_user: wordpress~wp_db_user: ${3}~" wordpressplaybook/group_vars/all  >> var.txt
sed -i "s~wp_db_password: password~wp_db_password: ${4}~" wordpressplaybook/group_vars/all  >> var.txt
ansible -m ping all  >>  var.txt
ansible-playbook wordpressplaybook/playbook.yml -i /etc/ansible/hosts -u ${1} >>  var.txt
}

sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> var.txt
sudo systemctl restart ssh

ssh_key_configuration ${1} ${2} ${3} >> var.txt
install_ansible >> var.txt
configure_ansible ${1} ${3} >> var.txt
wordpress_install ${3} ${4} ${5} ${6} >> var.txt

sed -i "s~   StrictHostKeyChecking no~#   StrictHostKeyChecking ask~" /etc/ssh/ssh_config  >> var.txt
systemctl restart ssh