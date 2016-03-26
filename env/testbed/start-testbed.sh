#!/bin/bash  
# @author: jaafar

# My functions

#Function check nodes
 

function check_node(){



if [ $? == 0 ]; then
	 
	 
	 
	 echo "
	 $1 Up and running !"  
	 #vagrant status	
	 
	#exit 0
else 
	
	
	echo "
	error ! $1 didn't launched successfully
	"
	
	#vagrant status
	
	
	exit 1 
fi



}

# function SLA 

function check_SLA(){


if [ $(ls -A $1) ]; then

echo '
... no SLA document found ... 

	
'

else 


SLA_DOC = $(ls -A $1)

echo '
... SLA document found !... 

	$SLA_DOC

'

fi

}

# Before launch 


echo "Hello


"
sleep 1

echo "This script will instantiate the following topology : "
echo "    "
echo "    "

echo " node1 <--> node5 <--> node6 <--> node2  "
echo  "            ||         ||               "
echo  "            ||         ||               "
echo " node3 <--> node7 <--> node8 <--> node4  "
echo "   

"


sleep 1

echo "Starting ..."

sleep 2
# the launch 

echo "
Checking the SLA repository ...
"
sleep 1
# CHeck the SLA 
check_SLA SLArepository

echo "Loading VMs please wait :=) 
"

vagrant up node1 2>>error.log

check_node node1

vagrant up node5 2>>error.log

check_node node5

vagrant up node2 2>>error.log

check_node node2

vagrant up node6 2>>error.log



check_node node6 node5 node2 node6

# show the topology image

echo "
==> Terminated
"
