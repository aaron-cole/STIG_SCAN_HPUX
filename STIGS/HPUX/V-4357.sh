#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Rotate audit logs daily to preserve audit file system space and to conform to the DoD requirement. If it is not rotated daily and moved to another location, then there is more of a chance for the compromise of audit data by malicious users.

#STIG Identification
GrpID="V-4357"
GrpTitle="GEN002860"
RuleID="SV-38427r1_rule"
STIGID="GEN002860"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
