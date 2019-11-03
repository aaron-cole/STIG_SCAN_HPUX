#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unauthorized users must not be allowed to access or modify the /etc/syslog.conf file.

#STIG Identification
GrpID="V-22454"
GrpTitle="GEN005395"
RuleID="SV-38375r1_rule"
STIGID="GEN005395"
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
file="/etc/syslog.conf"
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