#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of separate file systems for different paths can protect the system from failures resulting from a file system becoming full or failing.

#STIG Identification
GrpID="V-23738"
GrpTitle="GEN003623"
RuleID="SV-35054r1_rule"
STIGID="GEN003623"
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

if cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 2,2 -d " " | grep "^/var/.audit" | grep -v "/var/.audit/" >> $Results; then 
 cat /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | grep "/var/.audit" | grep -v "/var/.audit/" >> $Results
 echo "Pass" >> $Results
elif grep audit /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | cut -f 2,2 -d " " | grep "audit" | grep -v "audit/" >> $Results; then 
 grep audit /etc/fstab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" | grep "audit" | grep -v "audit/" >> $Results
 echo "Pass" >> $Results
else
 echo "audit logs are not on it's own filesystem" >> $Results
 echo "Fail" >> $Results
fi