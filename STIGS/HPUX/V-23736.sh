#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.

#STIG Identification
GrpID="V-23736"
GrpTitle="GEN003621"
RuleID="SV-35050r1_rule"
STIGID="GEN003621"
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

if cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 2,2 -d " " | grep "^/var" | grep -v "/var/" >> $Results; then 
 cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | grep "/var" | grep -v "/var/" >> $Results
 echo "Pass" >> $Results
else
 echo "/var is not on it's own filesystem" >> $Results
 echo "Fail" >> $Results
fi