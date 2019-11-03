#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/group file is critical to system security and must be protected from unauthorized modification.  The group file contains a list of system groups and associated information.

#STIG Identification
GrpID="V-22338"
GrpTitle="GEN001394"
RuleID="SV-38322r1_rule"
STIGID="GEN001394"
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
file="/etc/group"
ls -lLd $file >> $Results

if [ -e $file ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Fail" >> $Results
fi