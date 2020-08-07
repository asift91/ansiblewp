# Moodle Migration


## Migrate Moodle on Azure by two ways
## Option 1: Migrating Moodle with ARM templates
- For Moodle installation on Azure [click here](). 
- Above link will take you to the github repository where user can get the different types of Moodle installation links such as Minimal, Short-to-Mid, Large, Maximal.
- Pick the custom deployment if the above sizes are not equivalent with the user’s on-prem requirement.

- Moodle link will redirect to Azure Portal where user can need to fill mandatory fields such as Subscription, Resource Group, SSH key, Region.
- Click on purchase to start the deployment of Moodle on Azure
- The deployment will install Infrastructure and Moodle
- The infrastructure will create the following resources by using the predefined ARM template:
- Network Template
    * Template creates virtual network, subnet, Public IP, Load Balancer/App gateway.
- Storage Template
    * Creates storage account with provided type,kind and size(sku)
    * There are types of storage account such as NFS, Gluserfs, Azure Files
- Database Template
    * Create a Azure Database for MySQL server
- Virtual Machine Template
    * Creates a Virtual Machine (Controller VM) VM will be created with ubuntu OS 
    * Executes the script in the VM extension to install Moodle.
- ScaleSet Template
    * Creates a Virtual Machine Scale Set (VMSS) with the VM  instance.
    * Autoscaling of VM Instances depends on the CPU utilization.
    * VM instances are connected with the internal IP.
- There are other options defined to go for custom deployment such as Fully Configurable Deployment
- User can choose any of one to go for deployment
- After completion of  deployment go to the resource group in which the resources are deployed.
And navigate to the controller virtual machine 
- Login into it  with the same SSH key which was given during the deployment.
- Replace the Moodle and MoodleData directories
- Download and extract the zip files from the blob storage
- Creating database for moodle
- Download the tabase backup file from blob storage to the VM 

        
        azcopy copy 'https://mystorageaccount.blob.core.windows.net/mycontainer/myBlobDirectory/*' 'Path/to/folder'
        

- Create and Import the database backup file to MYSQL server in Azure

        mysqldump -h db_server_name -u db_login_name -pdb_pass db_name
        mysql -h db_server_name -u db_login_name -pdb_pass dbname
        
- Set the Moodle and Moodledata folder permissions.
- Set 755 and www-data owner:group permissions to Moodle folder

        sudo chmod 755 /moodle
        sudo chown -R www-data:www-data /moodle

- Set 770 and www-data owner:group permissions to MoodleData folder

        sudo chmod 755 /moodle/moodledata
        sudo chown -R www-data:www-data /moodle/moodledata

- Modify the Moodle, nginx, PHP configuration with on-prem.
- Change the database details in moodle configuration file (/moodle/config.php)
- Download and Copy the nginx config file from blob storage to the nginx config folder.
- Download and Copy the php config file from blob storage to the php config folder.
- Restart the nginx server and php-fpm

        sudo systemctl restart nginx
        sudo systemctl restart php(version)-fpm 
        ex: sudo systemctl restart php7.4-fpm 

- Hit the load balancer DNS name to get the Moodle page.
---
## Option 2: Migrating Moodle without template
- Here  user need  to create the infrastructure manually and migrate to Azure
- The Azure infrastructure is the basic skeleton of the resources which will host the moodle application.
- For installing the infrastructure for moodle navigate to the azure portal.
- In the dashboard go the the resource group section and create a resource group for the moodle infrastructure [Click here](https://ms.portal.azure.com/#blade/HubsExtension/BrowseResourceGroups)
- Once you create the resource group create resources into it.
- Network Resources: 
    * Create public Ip address for load balancer and controller VM
    * Create a standard load balancer
    * Create virtual network
    * Create subnet	
- Storage Resources
    * Create a storage account with with file fileserver type such as nfs, nfs-ha, azurefiles
        * For azurefiles create a file share
        * For nfs create a container 
- Database Resources
    * Create Azure Database for MySQL server

- Virtual Machine
    * Create a VM with ubuntu 16.04 / 18.04 operating system with SSH public key
    * Login into the VM with SSH and run the install_prerequisites.sh script
    * Above script will perform following task
    * Install web server (nginx/apache)
    * Install PHP with its extensions
    * Create a moodle shared folder (/moodle)
    * Run the migrate_moodle.sh script
    * Above script will download on-prem content from blob storage to VM
    * Extract the moodle zip file and copy to the shared folder (/moodle)
    * Copy the Moodledata folder to moodle shared folder (/moodle)
    * Set the configuration
    * Set the Moodle and Moodledata folder permissions.
    * Set 755 and www-data owner:group permissions to Moodle folder
        ```sh
        sudo chmod 755 /moodle
        sudo chown -R www-data:www-data /moodle 
        ```
    * Set 770 and www-data owner:group permissions to MoodleData folder
        ```
        sudo chmod 755 /moodle/moodledata
        sudo chown -R www-data:www-data /moodle/moodledata
        ```
- Creating database for moodle
    * Download the database backup file from blob storage to the VM 
        ```
        azcopy copy 'https://mystorageaccount.blob.core.windows.net/mycontainer/myBlobDirectory/*' 'Path/to/folder'
        ```
    * Create and Import the database backup file to MYSQL server in Azure
        ```
        mysqldump -h db_server_name -u db_login_name -pdb_pass db_name
        mysql -h db_server_name -u db_login_name -pdb_pass dbname
        ```
- ScaleSet:
    * Create a virtual machine scale set (VMSS)
    * Execute the webserver.sh script in the VMSS extension
    * Install webserver apache/nginx 
    * Install php with extensions 
    * Modify the Moodle, nginx, PHP configuration with on-prem.
    * Change the database details in moodle configuration file (/moodle/config.php)
    * Download and Copy the nginx config file from blob storage to the nginx config folder.
    * Download and Copy the php config file from blob storage to the php config folder.
    * Create a local copy of moodle from shared folder
- Set a cron job to copy the shared moodle content to /var/www/html/ folder whenever there is a change in timestamp in shared folder.
- Restart servers
- Restart nginx server 
- Restart php-fpm server

With the above steps Moodle infrastructure is ready 
 
User now hit the load balancer DNS name to get the migrated moodle web page.
 

