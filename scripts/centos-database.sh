#!/bin/bash


# MySQL installation

apt-get install -y  mysql-server

# MySQL permanant on boot

chkconfig --add mysql
chkconfig mysqld on 

# MySQL start

service mysql start

# to show that it works

mysql -u root -e "SHOW DATABASES";
