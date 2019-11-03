#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To centralize the management of privileged account crontabs, of the default system accounts, only root may have a crontab.

#STIG Identification
GrpID="V-11995"
GrpTitle="GEN003060"
RuleID="SV-38251r1_rule"
STIGID="GEN003060"
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
scorecheck=0
SYSACCTS="$(logins -s | awk '{print $1}' | grep -v "^root$")"

if [ -e /var/adm/cron/cron.allow ]; then
 echo "/var/adm/cron/cron.allow exists. Checking for System Accounts" >> $Results
 for SYSACCT in $SYSACCTS; do
  if egrep "^$SYSACCT$|^$SYSACCT $" /var/adm/cron/cron.allow >> $Results; then
   ((scorecheck+=1))
  fi
 done
elif [ -e /var/adm/cron/cron.deny ]; then
 echo "/var/adm/cron/cron.deny exists. Checking for System Accounts" >> $Results
 for SYSACCT in $SYSACCTS; do
  if ! egrep "^$SYSACCT$|^$SYSACCT $" /var/adm/cron/cron.deny >> $Results; then
   ((scorecheck+=1))
  fi
 done
else
 echo "cron.allow and cron.deny not found" >> $Results
 ((scorecheck+=1))
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi