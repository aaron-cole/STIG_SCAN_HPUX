#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the system is not configured to audit certain activities and write them to an audit log, it is more difficult to detect and track system compromises and damages incurred during a system compromise.

#STIG Identification
GrpID="V-819"
GrpTitle="GEN002820"
RuleID="SV-38483r1_rule"
STIGID="GEN002820"
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

if grep "AUDEVENT_ARGS1=" /etc/rc.config.d/auditing | grep -v "^#" | grep "\-e moddac " >> $Results; then
 echo "Pass" >> $Results
else
 echo "Audit Setting Not Found" >> $Results
 echo "Fail" >> $Results
fi