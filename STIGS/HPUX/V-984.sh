#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The at facility selectively allows users to execute jobs at deferred times.  It is usually used for one-time jobs. The at.allow file selectively allows access to the at facility.  If there is no at.allow file, there is no ready documentation of who is allowed to submit at jobs.

#STIG Identification
GrpID="V-984"
GrpTitle="GEN003280"
RuleID="SV-35033r1_rule"
STIGID="GEN003280"
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

if [ -e /var/adm/cron/at.allow ] || [ -e /var/adm/cron/at.deny ]; then
 ls -l /var/adm/cron/at.allow >> $Results 2>>/dev/null
 ls -l /var/adm/cron/at.deny >> $Results 2>>/dev/null
 echo "Pass" >> $Results
else
 echo "Neither file exists" >> $Results
 echo "Fail" >> $Results
fi