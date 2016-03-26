#!/bin/bash

# update centos
yum update -y --exclude=kernel
# Tools
yum install -y nano git unzip screen nc telnet
