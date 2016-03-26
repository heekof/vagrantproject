#!/bin/bash



ping -c 1 8.8.8.8 > /dev/null && apt-get update
 chmod 777 /etc/network/interfaces
 sysctl -w net.ipv4.ip_forward=1
 sysctl -p /etc/sysctl.conf
 cat /vagrant/topology/interfaces-topology-22-node-07 > /etc/network/interfaces 
 ifdown eth1 eth2 eth0
 ifup eth1 eth2 eth0
 /etc/init.d/networking restart 

 /etc/init.d/procps.sh restart