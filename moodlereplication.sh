#!/bin/bash

change_location() {
    echo "change locationfunction"
    sudo mkdir /azlamp/html/moodle.com
    sudo cp -rf /var/www/html/moodle/* /azlamp/html/moodle.com
}
configuring_certs() {
    echo "certs func"
    sudo mkdir /azlamp/certs/moodle.com
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /azlamp/certs/moodle.com/nginx.key -out /azlamp/certs/moodle.com/nginx.crt -subj "/C=US/ST=WA/L=Redmond/O=IT/CN=moodle.com"
    sudo chown www-data:www-data /azlamp/certs/moodle.com/nginx.*
    sudo chmod 400 /azlamp/certs/moodle.com/nginx.*

}
linking_data_location() {
    echo "linking func"
    sudo mkdir -p /azlamp/data/moodle.com/wp-content/uploads
    sudo ln -s /azlamp/data/moodle.com/wp-content/uploads /azlamp/html/moodle.com/wp-content/uploads
    sudo chmod 0777 /azlamp/data/moodle.com/wp-content/uploads
}
update_nginx_configuration() {
    echo "update nginx"
    cd /azlamp/bin/
    sudo sed -i "s~#1)~1)~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#    . /azlamp/bin/utils.sh~   . /azlamp/bin/utils.sh~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#    reset_all_sites_on_vmss true VMSS~    reset_all_sites_on_vmss true VMSS~" /azlamp/bin/update-vmss-config
    sudo sed -i "s~#;;~;;~" /azlamp/bin/update-vmss-config
    #echo "sleep for 30 seconds"
    sleep 30
}
replication() {
    echo "replication func"
    cd /usr/local/bin/
    sudo bash update_last_modified_time.azlamp.sh
}

# ${1} value is a domain name which will update in runtime
change_location ${1}
configuring_certs ${1}
linking_data_location ${1}
update_nginx_configuration
replication
