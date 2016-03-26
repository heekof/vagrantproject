#!/bin/bash

ping -c 1 8.8.8.8 > /dev/null && apt-get update


# apt-get install virtualbox-guest-utils

# configuration
 chmod 777 /etc/network/interfaces

# installer vlc 


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



# routage forwarding enabled
# 
 cat /vagrant/topology/interfaces-topology-22-node-01 > /etc/network/interfaces 
 ifdown eth1 eth2 eth0
 ifup eth1 eth2 eth0
 /etc/init.d/networking restart 




# Starting VLC streaming server
# sudo --user=vagrant  cvlc -vvv /vagrant/Video.mp4 --sout '#transcode{vcodec=h264,vb=800,acodec=none}:rtp{sdp=rtsp://192.168.1.11:1234/}'




