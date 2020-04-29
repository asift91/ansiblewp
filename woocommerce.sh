#!bin/bash

downloadwoocommerce(){
  wget -p https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip /home/italent/
}

extractfile(){
  tar xvf woocommerce.4.0.1.zip -C /var/www/html/domain/wp-content/plugin
}

downloadwoocommerce
extractfile

