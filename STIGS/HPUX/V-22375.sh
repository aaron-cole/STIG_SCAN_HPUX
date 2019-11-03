#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22375"
GrpTitle="GEN002730"
RuleID="SV-29653r1_rule"
STIGID="GEN002730"
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

if grep "AUDOMON_ARGS=" /etc/rc.config.d/auditing | grep -v "^#" | grep "\-w 9[0-9] " >> $Results; then
 echo "Pass" >> $Results
else
 echo "Audit Setting Not Found" >> $Results
 echo "Fail" >> $Results
fi