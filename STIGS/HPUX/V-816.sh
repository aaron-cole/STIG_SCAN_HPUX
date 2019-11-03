#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the system is not configured to audit certain activities and write them to an audit log, it is more difficult to detect and track system compromises and damages incurred during a system compromise.

#STIG Identification
GrpID="V-816"
GrpTitle="GEN002760"
RuleID="SV-38481r1_rule"
STIGID="GEN002760"
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

if grep "AUDEVENT_ARGS1=" /etc/rc.config.d/auditing | grep -v "^#" | grep "\-e admin " >> $Results; then
 if grep "AUDEVENT_ARGS1=" /etc/rc.config.d/auditing | grep -v "^#" | grep "\-e removable " >> $Results; then
  echo "Pass" >> $Results
 else
  echo "removable audit setting not found" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "admin audit Setting Not Found" >> $Results
 echo "Fail" >> $Results
fi