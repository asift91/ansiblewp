#!/bin/bash

decotext=`echo ${2} | base64 --decode`
  
echo "User ID is : ${1}" >> /home/"${1}"/log.txt
echo "encoded text : ${2}" >> /home/"${1}"/log.txt
echo "decoded text : ${decotext}" >> /home/"${1}"/log.txt

clonerepo(){
  cd /home/"${1}"/ 
  wget https://raw.githubusercontent.com/sayali0512/ansibles-wordpress-script/master/wordpressinstall.sh
  sudo chown -R "${1}":"${1}" /home/"${1}"/wordpressinstall.sh
}
clonerepo ${1} >> /home/"${1}"/log.txt

  cat <<EOF > /home/"${1}"/run.sh
  #!/bin/bash
  bash /home/${1}/wordpressinstall.sh ${decotext}
EOF
sudo chown -R "${1}":"${1}" /home/"${1}"/run.sh
