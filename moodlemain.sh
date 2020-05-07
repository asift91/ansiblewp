#!/bin/bash

decotext=`echo ${2} | base64 --decode`
  
echo "User ID is : ${1}" >> /home/"${1}"/log.txt
echo "encoded text : ${2}" >> /home/"${1}"/log.txt
echo "decoded text : ${decotext}" >> /home/"${1}"/log.txt

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

clonerepo(){
  cd /home/"${1}"/ 
  wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/moodleinstall.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/moodleinstall.sh
}

install_ansible
configure_ansible ${decotext}
clonerepo ${1} >> /home/"${1}"/log.txt

  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/moodleinstall.sh ${decotext}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
