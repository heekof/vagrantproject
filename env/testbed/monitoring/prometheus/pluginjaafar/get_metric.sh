#!/bin/bash  -x

set -


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

echo "Insert the mode number : 

1: JSONP file
2: JSON file
3: CSV file

"
read -p "Your choice ==> " OPTION

echo "Insert the host address : <host> "
read -p "Your choice ==> " HOST


echo "Insert the port : <port> "
read -p "Your choice ==> " PORT

echo "Insert scrapping interval in minutes : <port> "
read -p "Your choice ==> " INTERVAL


echo "
The address is $HOST:$PORT  with scapping interval of $INTERVAL min.
Thank you 
" 
}

###########################################################################################################
#		SET the time range for the API request - the range from time start to time end accordying to the RFC 3339
###########################################################################################################
function set_time() {

LOCAL_ADDED_MINUTES=$2
LOCAL_OPTION=$1

case "$LOCAL_OPTION" in
 "ADD")





LOCAL_TT="T"
LOCAL_ZZ="Z"

# Using the date command
LOCAL_RAW_TIME_DATE=$(date --rfc-3339=date --date=''$LOCAL_ADDED_MINUTES' minutes' --utc)
LOCAL_RAW_TIME_NS=$(date --rfc-3339=ns --date=''$LOCAL_ADDED_MINUTES' minutes' --utc)
# String Operations
LOCAL_RAW_TIME_NS=$(echo "${LOCAL_RAW_TIME_NS:11:12}")
LOCAL_RAW_TIME_DATE=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_TT)
LOCAL_RAW_TIME_NS=$(echo $LOCAL_RAW_TIME_NS$LOCAL_ZZ)
LOCAL_TIME_END=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_RAW_TIME_NS  )
# Print the result
TIME_END=$LOCAL_TIME_END

 ;;
  *)

LOCAL_TT="T"
LOCAL_ZZ="Z"
# Using the date command
LOCAL_RAW_TIME_DATE=$(date --rfc-3339=date  --date='2 minutes' --utc --universal)
LOCAL_RAW_TIME_NS=$(date --rfc-3339=ns --date='2 minutes' --utc --universal)
# String Operations
LOCAL_RAW_TIME_NS=$(echo "${LOCAL_RAW_TIME_NS:11:12}")
LOCAL_RAW_TIME_DATE=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_TT)
LOCAL_RAW_TIME_NS=$(echo $LOCAL_RAW_TIME_NS$LOCAL_ZZ)
LOCAL_TIME_START=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_RAW_TIME_NS  )
# Print the result
TIME_START=$LOCAL_TIME_START

     ;;
esac
}


###############################################
# option one
###############################################
function commands_api_option_one() {

HOST=$1 
PORT=$2 
INTERVAL=$3 

LINE_NUM=1
INDEX=1
INDEX_FILE=1
while read LINE 
do

echo "the raw metris used are: ==>      $INDEX : $LINE 
"

OUTPUT_FILE="data/file${INDEX_FILE}.json"

					while true
					do
					if [  ! -e $OUTPUT_FILE ]; then 
					
					
					echo " 
					$LINE ===> $OUTPUT_FILE
					"
					touch  ${OUTPUT_FILE}

					$( ${GOPATH}/bin/prom2json  http://${HOST}:${PORT}/metrics | jq '.[]|select(.name=='''$LINE''')'  > $OUTPUT_FILE ) 
 					
					break

					else
					
					((INDEX_FILE++))
					OUTPUT_FILE="data/file${INDEX_FILE}.json"
					fi
					done


((INDEX++))
((LINE_NUM++))
done < ./metrics-inputs














}


###############################################
# Option 2
###############################################


function commands_api_option_two() {


HOST=$1 
PORT=$2 
INTERVAL=$3 

INDEX_FILE="1"
INDEX="1"
OUTPUT_FILE="file${INDEX_FILE}.json"
# date --rfc-3339=ns --utc --universal

LOCAL_INTERVAL_MINUTES=$1

LOCAL_CMD_RET=$(curl -g 'http://'$HOST':'$PORT'/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step='$INTERVAL's -o data/${OUTPUT_FILE} > error.log')




set_time  "STD" $LOCAL_INTERVAL_MINUTES
set_time "ADD" $LOCAL_INTERVAL_MINUTES

# 15 seconds
STEP="15s"



LINE_NUM=1
while read LINE 
do

echo "the raw metris used are: ==>      $INDEX : $LINE 
"

OUTPUT_FILE="data/file${INDEX_FILE}.json"

					while true
					do
					if [  ! -e $OUTPUT_FILE ]; then 
					echo "create file data/$OUTPUT_FILE"
					touch  ${OUTPUT_FILE}
					echo " 
					The output file of the API request $LINE is in ===> data/$OUTPUT_FILE  
					"

					echo "debuggib : M= $LINE  time start = $TIME_START  step = $STEP  time end= $TIME_END "
					# the range from time start to time end accordying to the RFC 3339
					$(curl -g 'http://'$HOST':'$PORT'/api/v1/query_range?query='$LINE'&start='$TIME_START'&end='$TIME_END'&step='$STEP'' -o ""$OUTPUT_FILE"")
					#echo " The API request sent is :  http://localhost:9090/api/v1/query_range?query=$LINE&start=$TIME_START&end=$TIME_END&step=$STEP -o $OUTPUT_FILE "
					echo "the DEBUG = curl -g 'http://localhost:9090/api/v1/query_range?query=""$LINE""&start=""$TIME_START""&end=""$TIME_END""&step=""$STEP"" -o ""$OUTPUT_FILE""' "
					break

					else
					((INDEX_FILE++))
					OUTPUT_FILE="data/file${INDEX_FILE}.json"
					fi
					done


((INDEX++))
((LINE_NUM++))
done < ./metrics-inputs

}

##############################################################################################
##############################################################################################
############# Option 3: Write metrics into CSV File  #########################################
##############################################################################################
##############################################################################################
function commands_api_option_three() {

# get the HOST address 
HOST=$1 
# get the HOST port
PORT=$2 
# get The interval in seconds
INTERVAL=$3 
# Index for searching and naming files
INDEX_FILE="1"
# index
INDEX="1"
# Unix timestamp of NOW
NOW_UNIX_TIME=$(date +%s)


LINE_NUM=1
while read LINE 
do

echo "the raw metric used is: ==>      $INDEX : $LINE 
"

OUTPUT_FILE="data/file${INDEX_FILE}.csv"

					while true
					do
					if [  ! -e $OUTPUT_FILE ]; then 
					echo "create file $OUTPUT_FILE"
					touch  ${OUTPUT_FILE}
					echo " 
					The output file of the API request $LINE is in ===> data/$OUTPUT_FILE  
					"

					$(./prometheus_cli -csv=true -server="http://$HOST:$PORT"   query_range node_network_transmit_packets $NOW_UNIX_TIME $INTERVAL > $OUTPUT_FILE)

					break

					else
					((INDEX_FILE++))
					OUTPUT_FILE="data/file${INDEX_FILE}.csv"
					fi
					done


((INDEX++))
((LINE_NUM++))
done < ./metrics-inputs-csv

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
#



case $OPTION in
1*)

commands_api_option_one $HOST $PORT $INTERVAL 
  ;;
2*)
commands_api_option_two $HOST $PORT $INTERVAL
  ;;
3*)
  
commands_api_option_three $HOST $PORT $INTERVAL
  ;;
*)
  echo "Option not supported yet !"
  ;;
esac



exit 0


