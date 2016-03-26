#!/bin/bash

ping -c 1 8.8.8.8 > /dev/null && apt-get update

apt-get install virtualbox-guest-utils

 chmod 777 /etc/network/interfaces
 sysctl -w net.ipv4.ip_forward=1
 cat /vagrant/topology/interfaces-topology-22-node-03 > /etc/network/interfaces 
 ifdown eth1 eth2 eth0
 ifup eth1 eth2 eth0
 /etc/init.d/networking restart 
 sysctl -w net.ipv4.ip_forward=1