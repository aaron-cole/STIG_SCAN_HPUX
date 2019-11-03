#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If manual pages are compromised, misleading information could be inserted, causing actions possibly compromising the system.

#STIG Identification
GrpID="V-22316"
GrpTitle="GEN001290"
RuleID="SV-38282r2_rule"
STIGID="GEN001290"
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

checkfiles="$(find $(env | grep MANPATH | cut -f 2 -d "=" | tr ':' ' ') -type f -exec ls -al '{}' \; 2>>/dev/null | grep '^[a-zA-Z\-]\{10\}+')"

if [ -z "$checkfiles" ]; then
 echo "No man pages have ACLs" >> $Results
 echo "Pass" >> $Results
else
 echo "Man Page files have been found with an ACL" >> $Results
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
fi