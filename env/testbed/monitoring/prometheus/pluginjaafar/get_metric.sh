#!/bin/bash 

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

echo "Insert the host address : <host> "
read -p "Your choice ==> " HOST


echo "Insert the port : <port> "
read -p "Your choice ==> " PORT


echo "
The address is $HOST:$PORT  Thank you 
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
CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step=15s')

}


###############################################
# Option 2
###############################################


function commands_api_option_two() {
# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/series?match[]=up&match[]=go_memstats_next_gc_bytes{job="prometheus"}')
# CMD_RET=$(curl -g 'http://localhost:9090/api/v1/label/job/values')
# CMD_RET=$(curl 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T23:20:00.000Z&end=2016-03-25T23:32:00.000Z&step=15s')

INDEX_FILE="1"
OUTPUT_FILE="file${INDEX_FILE}.json"
# date --rfc-3339=ns --utc --universal

LOCAL_INTERVAL_MINUTES=$1
LOCAL_CMD_RET=$(curl -g 'http://localhost:9090/api/v1/query_range?query=up&start=2016-03-25T22:32:33.641Z&end=2016-03-25T22:52:33.641Z&step=15s -o ${OUTPUT_FILE} > error.log')



INDEX="1"
set_time  "STD" $LOCAL_INTERVAL_MINUTES
set_time "ADD" $LOCAL_INTERVAL_MINUTES

# 15 seconds
STEP="15s"



LINE_NUM=1
while read LINE 
do

echo "the raw metris used are: ==>      $INDEX : $LINE 
"

OUTPUT_FILE="file${INDEX_FILE}.json"

					while true
					do
					if [  ! -e $OUTPUT_FILE ]; then 
					echo "create file $OUTPUT_FILE"
					touch  $OUTPUT_FILE
					echo " 
					The output file of the API request $LINE is in ===> $OUTPUT_FILE  
					"

					echo "debuggib : M= $LINE  time start = $TIME_START  step = $STEP  time end= $TIME_END "
					# the range from time start to time end accordying to the RFC 3339
					$(curl -g 'http://'$HOST':'$PORT'/api/v1/query_range?query='$LINE'&start='$TIME_START'&end='$TIME_END'&step='$STEP'' -o ""$OUTPUT_FILE"")
					#echo " The API request sent is :  http://localhost:9090/api/v1/query_range?query=$LINE&start=$TIME_START&end=$TIME_END&step=$STEP -o $OUTPUT_FILE "
					echo "the DEBUG = curl -g 'http://localhost:9090/api/v1/query_range?query=""$LINE""&start=""$TIME_START""&end=""$TIME_END""&step=""$STEP"" -o ""$OUTPUT_FILE""' "
					break

					else
					((INDEX_FILE++))
					OUTPUT_FILE="file${INDEX_FILE}.json"
					fi
					done


((INDEX++))
((LINE_NUM++))
done < ./metrics-inputs

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



start $1
commands_api_option_two $1 $OPTION


exit 0


