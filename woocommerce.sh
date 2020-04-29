#!bin/bash

downloadwoocommerce(){
  wget -p /home/italent/https://downloads.wordpress.org/plugin/woocommerce.4.0.1.zip
}

extractfile(){
  tar xvf woocommerce.4.0.1.zip -C /$7/wp-content/plugin
}

downloadwoocommerce
extractfile

