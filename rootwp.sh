#!/bin/bash
echo "Public Ip is : ${1}" >> $path/var.txt
echo "Password is : ${2}" >> $path/var.txt
echo "username is : ${3}" >> $path/var.txt
echo "dbservername is : ${4}" >> $path/var.txt
echo "dbusername is : ${5}" >> $path/var.txt
echo "dbPassword is : ${6}" >> $path/var.txt
path = /var/lib/waagent/custom-script/download/0 >> $path/var.txt

ssh_key_configuration ${1} ${2} ${3} >> $path/var.txt
install_ansible >> $path/var.txt
configure_ansible ${1} ${3} >> $path/var.txt
wordpress_install ${3} ${4} ${5} ${6} >> $path/var.txt

ssh_key_configuration() {
apt-get update  >> $path/var.txt
echo "---------------------------------------------------------------------------" >> $path/var.txt
apt-get install sshpass  >> $path/var.txt
apt-cache search sshpass  >> $path/var.txt
echo "---------------------------------------------------------------------------" >> $path/var.txt
mkdir $path/.ssh
ssh-keygen -t rsa -N '' -f $path/.ssh/id_rsa <<< y
echo "---------------------------------------------------------------------------" >> $path/var.txt
#echo "Changing permissions for id_rsa" >> $path/var.txt
 #sudo chown ${3}:${3} $path/.ssh/id_rsa* >> $path/var.txt
echo "---------------------------------------------------------------------------"
echo "before ssh-copy-id command" >> $path/var.txt
echo "---------------------------------------------------------------------------"
 # echo "${2}" | sshpass ssh-var-id -f -i $path/.ssh/id_rsa.pub ${3}@${1} >> $path/var.txt
sshpass -p "${2}" ssh-copy-id -i $path/.ssh/id_rsa.pub ${3}@${1} >> $path/var.txt
echo "---------------------------------------------------------------------------"
echo "after ssh-copy-id command" >> $path/var.txt
echo "---------------------------------------------------------------------------"
}

install_ansible() {
apt update
#sudo apt install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y
}

configure_ansible() {
echo "Configure ansible Ip is : ${1}" >> /home/${2}/var.txt
sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> /home/${2}/var.txt
chmod 777 /etc/ansible/hosts
echo -e "[webservers]\n${1}" >>/etc/ansible/hosts
#sudo chown -R ${2}:${2} /home/${2}/.ansible/cp
}

wordpress_install() {
#cd /home/${1}
git clone https://github.com/sayosh0512/wordpressplaybook.git
#sudo chown -R ${1}:${1} /home/${1}/wordpressplaybook
echo "username is : ${1}" >> /home/${1}/var.txt
echo "dbservername is : ${2}" >> /home/${1}/var.txt
echo "dbusername is : ${3}" >> /home/${1}/var.txt
echo "dbPassword is : ${4}" >> /home/${1}/var.txt
sed -i "s~wp_db_name: wordpress~wp_db_name: ${2}~" $path/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt
sed -i "s~wp_db_user: wordpress~wp_db_user: ${3}~" $path/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt 
sed -i "s~wp_db_password: password~wp_db_password: ${4}~" $path/wordpressplaybook/group_vars/all  >> /home/${1}/var.txt 
ansible -m ping all  >>  /home/${1}/var.txt
ansible-playbook $path/wordpressplaybook/playbook.yml -i /etc/ansible/hosts -u ${1} >>  /home/${1}/var.txt
}

#sudo sed -i "s~#   StrictHostKeyChecking ask~   StrictHostKeyChecking no~" /etc/ssh/ssh_config  >> $path/var.txt
#sudo systemctl restart ssh

sed -i "s~   StrictHostKeyChecking no~#   StrictHostKeyChecking ask~" /etc/ssh/ssh_config  >> $path/var.txt
systemctl restart ssh