#!/bin/bash

decotext=`echo ${2} | base64 --decode`
  
echo "User ID is : ${1}" >> /home/"${1}"/log.txt
echo "encoded text : ${2}" >> /home/"${1}"/log.txt
echo "decoded text : ${decotext}" >> /home/"${1}"/log.txt

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

clonerepo(){
  cd /home/"${1}"/ 
  wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/moodleinstall.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/moodleinstall.sh
}

ssh_key_configuration 
install_ansible
configure_ansible ${decotext}
clonerepo ${1} >> /home/"${1}"/log.txt

  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/moodleinstall.sh ${decotext}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
