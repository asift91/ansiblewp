#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y subversion 

cd /home/azureadmin/
svn checkout https://github.com/asift91/ansible_playbook/trunk/roles
