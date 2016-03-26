#!/bin/bash
function start(){

echo "Hello" 
echo " This Program will allow you to send a group of query to the node you are monitoring and store the response 
in a JSON file created dynamically as file1, file2, file3, etc. "
echo " 
This program has several mode "
echo " options : 1 - 2 - 3"
echo "The mode 1 allow you to get basic metrics from the node targerted by prometheus  "
read -p "Your choice ==> " OPTION 

echo "
Your choice was the activation of the mode $OPTION " 
}

# send the query  can also use curl -o outputfile.txt

function commands_api_option_one() {


# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/series?match[]=up&match[]=go_memstats_next_gc_bytes{job="prometheus"}')
# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/label/job/values')
# CMD_RET=$(curl 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T23:20:00.000Z&end=2016-03-25T23:32:00.000Z&step=15s')

CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step=15s')

METRIC="process_virtual_memory_bytes process_cpu_seconds_total "



}

# store the the response  in a JSON file format

function storage(){

for VAR in  1 2 3 5 6 7 8 9 10
do
if [  ! -e file${VAR} ]; then 


echo "create file $VAR"


touch  file${VAR}

echo "$CMD_RET" > file${VAR}  2>error.log


exit 0

else


echo "file $VAR found"

fi

done
}


start

case "$OPTION" in
 "1"*|"one")

 commands_api_option_one
 storage

     ;;

 "2"*|"two")

echo "choice 2"

  ;;

 "3"*|"three")

echo "choice 3"

 ;;

  *)
echo "Option not supported yet"
exit 0
     ;;
esac


# After, I should use a table to gather all my query response
exit 0


