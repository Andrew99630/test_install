#!/bin/bash

sudo apt update
sudo apt install -y python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx curl

sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv

virtualenv env
source env/bin/activate
pip install -r requirements.txt

sudo cp /var/www/test_install/systemd/gunicorn.service /etc/systemd/system/
sudo cp /var/www/test_install/systemd/gunicorn.socket /etc/systemd/system/

sudo cp /var/www/test_install/nginx/nginx.conf /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/


sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart