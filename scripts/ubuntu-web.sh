#!/bin/bash


# test
ping -c 1 8.8.8.8 > /dev/null && apt-get update 


#  Apache








# Check if internet is accessible 
VAR=$(ping -c 1 8.8.8.8 | grep -c '100% packet loss')
if [ $VAR -eq 0 ]; then
dpkg -l | grep apache2  || apt-get install -y apache2 apache2-utils apache2-mpm-prefork apache2-mpm-worker apache2-mpm-itk
# PHP 

dpkg -l | grep php5  || apt-get install -y php5 php5-mysql libapache2-mod-php5 mysql-server 


exit 0
#dpkg -l | grep vlc  || apt-get install -y vlc
else
echo "No internet connexion"
exit 1
fi







cd /etc/apache2 
service apache2  stop
service apache2  start



rm -rf /var/www/html

if [ ! -d "/vagrant/www" ]; then
mkdir /vagrant/www
fi

ln -s /vagrant/www /var/www/html







# Download starter content 
cd /vagrant/www 

ls /vagrant/www/index.html || sudo -u vagrant touch index.html
ls /vagrant/www/info.php || sudo -u vagrant touch info.php

service apache2 restart 
