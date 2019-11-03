#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.

#STIG Identification
GrpID="V-23739"
GrpTitle="GEN003624"
RuleID="SV-35055r1_rule"
STIGID="GEN003624"
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

if cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 2,2 -d " " | grep "^/tmp" | grep -v "/tmp/" >> $Results; then 
 cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | grep "/tmp" | grep -v "/tmp/" >> $Results
 echo "Pass" >> $Results
else
 echo "/tmp is not on it's own filesystem" >> $Results
 echo "Fail" >> $Results
fi