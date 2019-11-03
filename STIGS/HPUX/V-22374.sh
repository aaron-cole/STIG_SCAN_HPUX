#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22374"
GrpTitle="GEN002719"
RuleID="SV-38356r1_rule"
STIGID="GEN002719"
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

if grep -v "^#" /etc/rc.config.d/auditing | grep "^AUDOMON_ARGS=" | grep " -o " >> $Results; then
 echo "audomon invoked with the -o option and is writting to log files" >> $Results
 echo "Pass" >> $Results
else
 echo "audomon IS NOT invoked with the -o option" >> $Results
 echo "Fail" >> $Results
fi