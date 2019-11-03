#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-4382"
GrpTitle="GEN004220"
RuleID="SV-35158r1_rule"
STIGID="GEN004220"
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

checkfiles="$(find ~root -type d \( -name \.mozilla -o -name .netscape \))"

if [ -z "$checkfiles" ]; then
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
else
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
fi