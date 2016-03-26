#!/bin/bash


########################################################################
# ----------------------- My Functions --------------------------------#    
########################################################################


###############################################
#  start
###############################################
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


###############################################
# send the query  can also use curl -o outputfile.txt
###############################################
function send_api_request(){
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ COntinue here
# local variable : the received raw metric
LOCAL_METRIC=$1
# the range from time start to time end accordying to the RF 3339
LOCAL_TIME_START
LOCAL_TIME_END
# 15 seconds
STEP="15"

LOCAL_CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=${LOCAL_METRIC}&start=${LOCAL_TIME_START}Z&end=${LOCAL_TIME_END}Z&step=${STEP}s')


}

###############################################
# option one
###############################################
function commands_api_option_one() {
CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step=15s')

}


###############################################
# Option 2
###############################################


function commands_api_option_two() {
# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/series?match[]=up&match[]=go_memstats_next_gc_bytes{job="prometheus"}')
# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/label/job/values')
# CMD_RET=$(curl 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T23:20:00.000Z&end=2016-03-25T23:32:00.000Z&step=15s')

LOCAL_CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step=15s')

LOCAL_METRIC="process_virtual_memory_bytes  process_cpu_seconds_total  go_memstats_next_gc_bytes  prometheus_local_storage_persistence_urgency_score
go_gc_duration_seconds go_memstats_alloc_bytes go_memstats_mspan_inuse_bytes"
INDEX="1"
for M in $LOCAL_METRIC 
do
echo "the raw metris used are: ==>      $INDEX : $M"
send_api_request $M
((INDEX++))
done

}


###############################################
# store the the response  in a JSON file format
###############################################
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













########################################################################
# ----------------------- The begining --------------------------------#    
########################################################################			



start

case "$OPTION" in
 "1"*|"one")

 commands_api_option_one
 storage

     ;;

 "2"*|"two")

echo "choice 2"

commands_api_option_two

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


