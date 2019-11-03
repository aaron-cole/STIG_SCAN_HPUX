#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#On some systems, if there is no at.allow file and there is an empty at.deny file, then the system assumes everyone has permission to use the at facility. This could create an insecure setting in the case of malicious users or system intruders.

#STIG Identification
GrpID="V-985"
GrpTitle="GEN003300"
RuleID="SV-38551r1_rule"
STIGID="GEN003300"
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

if [ -e /var/adm/cron/at.allow ]; then
 ls -l /var/adm/cron/at.allow >> $Results 2>>/dev/null
 echo "Pass" >> $Results
elif [ ! -e /var/adm/cron/at.allow ] && [ -n /var/adm/cron/at.deny ]; then
 cat /var/adm/cron/at.deny >> $Results
 echo "Pass" >> $Results
else
 echo "/var/adm/cron/at.allow doesn't exist and /var/adm/cron/at.deny doesn't exist or is empty" >> $Results
 echo "Fail" >> $Results
fi