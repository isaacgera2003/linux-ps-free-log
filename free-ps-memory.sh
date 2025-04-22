#!/bin/bash
if [ "$EUID" -ne 0 ]; then
	echo "Need root privilages...";
	exit 1;
fi
HOSTNAME=`hostname`

mkdir -p /var/log/free-ps
while true
do
	LOGFILE="/var/log/free-ps/ps-free-$(date +%d-%m-%Y).log";
	echo -e "\t\tTime Stamp: $(date +%T)" >> $LOGFILE;
	echo -e "\t\tHost Name: $HOSTNAME" >> $LOGFILE;
	echo -e "\t\tMemory Utilization: $(free | awk 'NR==2 {printf("%.2f",($3/$2)*100)}')%" >> $LOGFILE;
	echo "--------------------------------------------------------------" >> $LOGFILE;
	free -h | awk -F ' ' 'NR==1 {print "\t" $1 "\t" $2 "\t" $3 "\t" $6;next} {print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $7}' >> $LOGFILE;
	echo "--------------------------------------------------------------" >> $LOGFILE;
	ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 >> $LOGFILE;
	echo "==============================================================" >> $LOGFILE;
	sleep 60;
done
