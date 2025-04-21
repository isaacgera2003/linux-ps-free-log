#!/bin/bash

PWD=`pwd`
HOSTNAME=`hostname`

mkdir -p $PWD/logs
while true
do
	LOGFILE="$PWD/logs/ps-free-$(date +%d-%m-%Y).log";
	echo -e "\t\tTime Stamp: $(date +%T)" >> $LOGFILE;
	echo -e "\t\tHost Name: $HOSTNAME" >> $LOGFILE;
	echo -e "\t\tMemory Utilization: $(free | awk 'NR==2 {printf("%.2f",($3/$2)*100)}')%" >> $LOGFILE;
	echo "----------------------------------------------------------" >> $LOGFILE;
	free -h | awk -F ' ' 'NR==1 {print "\t" $1 "\t" $2 "\t" $3 "\t" $6;next} {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $7}' >> $LOGFILE;
	echo "----------------------------------------------------------" >> $LOGFILE;
	ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 >> $LOGFILE;
	echo "==========================================================" >> $LOGFILE;
	sleep 60;
done
