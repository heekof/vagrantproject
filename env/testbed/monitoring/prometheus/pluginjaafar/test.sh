#!/bin/bash 

# the range from time start to time end accordying to the RFC 3339
#		SET the time range for the API request
#
function SET_TIME() {

ADDED_MINUTES=$2
OPTION=$1
case "$OPTION" in
 "ADD")





LOCAL_TT="T"
LOCAL_ZZ="Z"

# Using the date command
LOCAL_RAW_TIME_DATE=$(date --rfc-3339=date --date=''$ADDED_MINUTES' minutes' --utc)
LOCAL_RAW_TIME_NS=$(date --rfc-3339=ns --date=''$ADDED_MINUTES' minutes' --utc)

# String Operations
LOCAL_RAW_TIME_NS=$(echo "${LOCAL_RAW_TIME_NS:11:12}")
LOCAL_RAW_TIME_DATE=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_TT)
LOCAL_RAW_TIME_NS=$(echo $LOCAL_RAW_TIME_NS$LOCAL_ZZ)
LOCAL_TIME_START=$(echo $LOCAL_RAW_TIME_DATE$LOCAL_RAW_TIME_NS  )

# Print the result
TIME_END=$LOCAL_TIME_START
 

 ;;
 
 
 *)




LOCAL_TT="T"
LOCAL_ZZ="Z"

# Using the date command
LOCAL_RAW_TIME_DATE=$(date --rfc-3339=date --utc --universal)
LOCAL_RAW_TIME_NS=$(date --rfc-3339=ns --utc --universal)

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

PARA1=$1
PARA2=$2

SET_TIME "ADD" $PARA2
SET_TIME "XXX" $PARA2
STEP="15s"
M="process_virtual_memory_bytes"


echo "
curl -g 'http://localhost:9090/api/v1/query_range?query=$M&start=$TIME_START&end=$TIME_END&step=$STEP'
"

$(curl -g 'http://localhost:9090/api/v1/query_range?query='$M'&start='$TIME_START'&end='$TIME_END'&step='$STEP'')
