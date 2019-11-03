#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Cron logging can be used to trace the successful or unsuccessful execution of cron jobs.  It can also be used to spot intrusions into the use of the cron facility by unauthorized and malicious users.

#STIG Identification
GrpID="V-982"
GrpTitle="GEN003160"
RuleID="SV-38549r1_rule"
STIGID="GEN003160"
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

fdexists="/var/adm/cron/log"

if [ ! -e $fdexists ]; then
 echo "$fdexists does not exist" >> $Results
 echo "Fail" >> $Results
else
 echo "$(ls -l $fdexists)" >> $Results
 echo "Pass" >> $Results
fi