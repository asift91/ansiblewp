#!/bin/bash

echo "User ID is : ${1}" >>log.txt
echo "Command is : ${2}" >> log.txt

clonerepo(){
  cd /home/"${1}"/ || exit
  wget https://raw.githubusercontent.com/sayosh0512/ansibles-wordpress-script/master/wordpressinstall.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/wordpressinstall.sh
}
createrunscript(){
  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/wordpressinstall.sh ${2}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
}
clonerepo ${1} >> log.txt
createrunscript ${1} "${2}" >> log.txt
