#!/bin/bash
downloadwoocommerce(){
  wget -p https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /home/azureadmin/
}
extractfile(){
  echo "domain_name ${1}" >>/home/azureadmin/log.txt
  sudo apt install unzip
  #cd /home/azureadmin/downloads.wordpress.org/plugin/
  sudo unzip /home/azureadmin/downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /var/www/html/${1}/wp-content/plugin
}
downloadwoocommerce
extractfile ${1}
