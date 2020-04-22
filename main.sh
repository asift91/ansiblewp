#!/bin/bash

cd /home/${3}/ >> log.txt

git clone https://github.com/asift91/ansiblewp.git  >> log.txt

sudo chown -R ${3}:${3} /home/{3}/ansiblewp

