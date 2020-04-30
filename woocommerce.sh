#!/bin/bash
downloadwoocommerce(){
  wget -p https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /home/azureadmin/
}
change_location(){
    sudo mkdir /azlamp/html/${1}
    sudo cp -rf /var/www/html/wordpress/* /azlamp/html/${1}
}
extractfile(){
  echo "domain_name ${1}" >>/home/azureadmin/log.txt
  sudo apt install unzip
  #cd /home/azureadmin/downloads.wordpress.org/plugin/
  sudo unzip /home/azureadmin/downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /var/www/html/${1}/wp-content/plugin
}
downloadwoocommerce
change_location ${1} 
extractfile ${1}
