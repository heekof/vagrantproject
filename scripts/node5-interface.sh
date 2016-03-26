#!/bin/bash
#apt-get update


ping -c 1 8.8.8.8 > /dev/null && apt-get update

 sysctl -w net.ipv4.ip_forward=1
 sysctl -p /etc/sysctl.conf
 
 chmod 777 /etc/network/interfaces
 
 cat /vagrant/topology/interfaces-topology-22-node-05 > /etc/network/interfaces 
 
 ifdown eth1 eth2 eth0
 
 ifup eth1 eth2 eth0
 #1 > /proc/sys/net/ipv4/ip_forward
 /etc/init.d/networking restart 
 #/etc/init.d/procps.sh restart

 
 # On start change the forwarding ip4 please 