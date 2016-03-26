#!/bin/bash 


LINE_NUM=1
while read LINE
do
	
	
	METRIC.=" "${LINE}" "

echo "${LINE_NUM} : ${LINE}"

((LINE_NUM++))
done < ./metrics-inputs

