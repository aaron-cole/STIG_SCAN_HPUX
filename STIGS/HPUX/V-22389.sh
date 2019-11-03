#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If there are excessive file permissions for the cron.deny file, sensitive information could be viewed or edited by unauthorized users.

#STIG Identification
GrpID="V-22389"
GrpTitle="GEN003210"
RuleID="SV-38362r1_rule"
STIGID="GEN003210"
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
file="/var/adm/cron/cron.deny"

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