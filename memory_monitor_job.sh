#!/bin/bash

filename="ps-free-$(date +%d-%m-%Y).log";
hostname=`hostname`
mkdir -p $(pwd)/logs

while true
do
	echo "		     Timestamp: $(date +%T)" >> $(pwd)/logs/$filename;
	echo "                     Hostname: $hostname" >> $(pwd)/logs/$filename;
	echo "--------------------------------------------------------------" >> $(pwd)/logs/$filename;
	free -h | awk -F ' ' 'NR==1 {print "\t" $1 "\t" $2 "\t" $3 "\t" $6 "\t" $7;next}{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $7}' >> $(pwd)/logs/$filename;
	echo "--------------------------------------------------------------" >> $(pwd)/logs/$filename;
	ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n6 >> $(pwd)/logs/$filename;
	echo "==============================================================" >> $(pwd)/logs/$filename;
	sleep 60;
done

