#!/bin/bash

#Install git and nano

# yum install -y git
# yum install -y nano

touch My_file
echo "This is my file" > My_file
sudo cp -v My_file /vagrant/
