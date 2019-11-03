#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The cron facility allows users to execute recurring jobs on a regular and unattended basis. The cron.allow file designates accounts allowed to enter and execute jobs using the cron facility. If neither cron.allow nor cron.deny exists, then any account may use the cron facility. This may open the facility up for abuse by system intruders and malicious users.

#STIG Identification
GrpID="V-974"
GrpTitle="GEN002960"
RuleID="SV-38541r1_rule"
STIGID="GEN002960"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Check

if [ -e /var/adm/cron/cron.allow ] || [ -e /var/adm/cron/cron.deny ]; then
 ls -l /var/adm/cron/cron.allow >> $Results 2>>/dev/null
 ls -l /var/adm/cron/cron.deny >> $Results 2>>/dev/null
 echo "Pass" >> $Results
else
 echo "Neither file exists" >> $Results
 echo "Fail" >> $Results
fi
