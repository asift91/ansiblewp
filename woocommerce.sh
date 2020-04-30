#!/bin/bash
downloadwoocommerce(){
  wget -p https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /home/${1}/
}

extractfile(){
  echo "domain_name ${1}" >>/home/${2}/log.txt
  sudo apt install unzip
  sudo unzip /home/${2}/downloads.wordpress.org/plugin/woocommerce.4.0.1.zip
  sudo cp -rf /home/${2}/woocommerce /var/www/html/wordpress/wp-content/plugins/
  sudo rm -rf /home/${2}/woocommerce
}
downloadwoocommerce ${2}
extractfile ${1} ${2} 
