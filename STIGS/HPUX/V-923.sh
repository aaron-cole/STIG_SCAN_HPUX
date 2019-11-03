#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an unauthorized device is allowed to exist on the system, there is the possibility the system may perform unauthorized operations.

#STIG Identification
GrpID="V-923"
GrpTitle="GEN002260"
RuleID="SV-38504r1_rule"
STIGID="GEN002260"
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

if ps -ef | grep -i tripwire | grep -v grep >> $Results; then
 echo "Tripwire installed and Running" >> $Results
 echo "Pass" >> $Results
else
 echo "Tripwire is not installed and running" >> $Results
 echo "What other file integrity tool is used?" >> $Results
 echo "Fail" >> $Results 
fi