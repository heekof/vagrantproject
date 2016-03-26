#!/bin/bash

ping -c 1 8.8.8.8 > /dev/null && apt-get update

# ping -c 1 8.8.8.8 > /dev/null && apt-get install virtualbox-guest-utils

 chmod 777 /etc/network/interfaces

sudo --user=vagrant setxkbmap fr

# install vlc if not found  

# Check if internet is accessible 
VAR=$(ping -c 1 8.8.8.8 | grep -c '100% packet loss')
if [ $VAR -eq 0 ]; then

dpkg -l | grep vlc  || apt-get install -y vlc 

exit 0

#dpkg -l | grep vlc  || apt-get install -y vlc

else

echo "No internet connexion"
exit 1
fi
 
 
# Configure the network interfaces 
# Ethernet and ip interfaces 
cat /vagrant/topology/interfaces-topology-22-node-02 > /etc/network/interfaces 
 
 
# Applying network config. changes
ifdown eth1 eth2 eth0
ifup eth1 eth2 eth0 
/etc/init.d/networking restart 



# Building the GUI Inteface to see the video streaming 
# apt-get install lubuntu-desktop -y

#fetching and playing the video 

#sudo --user=vagrant  vlc -vvv --network-caching 200 rtsp://192.168.1.11:1234/
