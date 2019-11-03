#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Without auditing, individual system accesses cannot be tracked and malicious activity cannot be detected and traced back to an individual account.

#STIG Identification
GrpID="V-811"
GrpTitle="GEN002660"
RuleID="SV-38476r1_rule"
STIGID="GEN002660"
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
audsys >> $Results

if audsys | grep "auditing system is currently on" >> /dev/null 2>>/dev/null; then
 echo "Pass" >> $Results
else
 echo "Fail" >> $Results
fi
