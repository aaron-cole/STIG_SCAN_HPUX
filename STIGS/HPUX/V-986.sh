#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Default accounts, such as bin, sys, adm, uucp, daemon, and others, should never have access to the at facility. This would create a possible vulnerability open to intruders or malicious users.

#STIG Identification
GrpID="V-986"
GrpTitle="GEN003320"
RuleID="SV-38552r1_rule"
STIGID="GEN003320"
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
 if egrep "daemon|bin|sys|adm|uucp|lp|nuucp|hpdb|nobody|www|cimsrvr|sfmdb|iwww|owww|hpsmh|sshd|ids" /var/adm/cron/at.allow >> $Results; then
  echo "Default accounts found in /var/adm/cron/at.allow" >> $Results
  echo "Fail" >> $Results
 else
  echo "Contents of /var/adm/cron/at.allow" >> $Results
  cat /var/adm/cron/at.allow >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/var/adm/cron/at.allow does not exist" >> $Results
 echo "Pass" >> $Results
fi
