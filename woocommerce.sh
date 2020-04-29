#!bin/bash
downloadwoocommerce(){
  wget -p https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /var/www/html/domain/wp-content/
}
extractfile(){
  apt install unzip
  #cd /home/azureadmin/downloads.wordpress.org/plugin/
  unzip /home/azureadmin/downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /var/www/html/domain/wp-content/plugin
}
downloadwoocommerce
extractfile

