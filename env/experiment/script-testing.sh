#!/bin/bash 


#set -x

# installer vlc 


VAR=$(ping -c 1 8.8.8.8 | grep -c '100% packet loss')


if [ $VAR -eq 0 ]; then

echo "internet connexion"
exit 0

#dpkg -l | grep vlc  || apt-get install -y vlc

else

echo "No internet connexion"
exit 1

fi