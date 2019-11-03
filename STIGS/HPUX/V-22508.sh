#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Extended attributes in file systems are used to contain arbitrary data and file metadata with possible security implications.

#STIG Identification
GrpID="V-22508"
GrpTitle="GEN006571"
RuleID="SV-35190r1_rule"
STIGID="GEN006571"
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