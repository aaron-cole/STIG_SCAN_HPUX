#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Cron logs contain reports of scheduled system activities and must be protected from unauthorized access or manipulation.

#STIG Identification
GrpID="V-22388"
GrpTitle="GEN003190"
RuleID="SV-38361r1_rule"
STIGID="GEN003190"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
file="/var/adm/cron/log"
ls -lLd $file >> $Results

if [ -e $file ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi