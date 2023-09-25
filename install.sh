#!/bin/bash
base_python_interpreter="/usr/bin/python3.10"
project_domain="credit-inspector.ru"
project_path=`pwd`

#read -p "Python interpreter: " base_python_interpreter
#read -p "Your domain without protocol (for example, google.com): " project_domain
# shellcheck disable=SC2092
# shellcheck disable=SC2006
`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install -r requirements.txt

sed -i "s~dbms_template_path~$project_path~g" nginx/site.conf systemd/gunicorn.service
sed -i "s~dbms_template_domain~$project_domain~g" test_install/settings.py

sudo ln -s $project_path/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s $project_path/systemd/gunicorn.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart