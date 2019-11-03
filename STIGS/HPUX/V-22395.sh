#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the at directory has an extended ACL, unauthorized users could be allowed to view or to edit files containing sensitive information within the at directory. Unauthorized modifications could result in Denial of Service to authorized at jobs.

#STIG Identification
GrpID="V-22395"
GrpTitle="GEN003410"
RuleID="SV-38364r1_rule"
STIGID="GEN003410"
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
file="/var/spool/cron/atjobs"
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