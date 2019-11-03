#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-24357"
GrpTitle="GEN002870"
RuleID="SV-38413r1_rule"
STIGID="GEN002870"
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


if crontab -l | grep "/audit/scripts/AuditLogMaint" >> $Results; then
 echo "Audit Logs are being rotated" >> $Results
 echo "Pass" >> $Results
else
 echo "Manual Review - Are audit logs being rotated" >> $Results
 echo "Fail" >> $Results
fi
