#!/bin/bash

change_location() {
    echo "change locationfunction"
    sudo mkdir /azlamp/html/wptest.com
    sudo cp -rf /var/www/html/wordpress/* /azlamp/html/wptest.com
}
configuring_certs() {
    echo "certs func"
    sudo mkdir /azlamp/certs/wptest.com
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /azlamp/certs/wptest.com/nginx.key -out /azlamp/certs/wptest.com/nginx.crt -subj "/C=US/ST=WA/L=Redmond/O=IT/CN=wptest.com"
    sudo chown www-data:www-data /azlamp/certs/wptest.com/nginx.*
    sudo chmod 400 /azlamp/certs/wptest.com/nginx.*

}
linking_data_location() {
    echo "linking func"
    sudo mkdir -p /azlamp/data/wptest.com/wp-content/uploads
    sudo ln -s /azlamp/data/wptest.com/wp-content/uploads /azlamp/html/wptest.com/wp-content/uploads
    sudo chmod 0777 /azlamp/data/wptest.com/wp-content/uploads
}
update_nginx_configuration() {
    echo "update nginx"
    cd /azlamp/bin/
    sudo sed -i "s~#1)~1)~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#    . /azlamp/bin/utils.sh~   . /azlamp/bin/utils.sh~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#    reset_all_sites_on_vmss true VMSS~    reset_all_sites_on_vmss true VMSS~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#;;~;;~" /azlamp/bin/update-vmss-config
    #echo "sleep for 60 seconds"
    sleep 30
}
replication() {
    echo "replication func"
    cd /usr/local/bin/
    sudo bash update_last_modified_time.azlamp.sh
}
change_location >>/home/azureadmin/copy.txt
configuring_certs >>/home/azureadmin/copy.txt
linking_data_location >>/home/azureadmin/copy.txt
update_nginx_configuration >>/home/azureadmin/copy.txt
replication >>/home/azureadmin/copy.txt