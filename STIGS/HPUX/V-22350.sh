#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on home directories allow unauthorized access to user files.

#STIG Identification
GrpID="V-22350"
GrpTitle="GEN001490"
RuleID="SV-38324r1_rule"
STIGID="GEN001490"
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

checkfiles="$(cut -f 6 -d ":" /etc/passwd | xargs -n1 ls -lLd | grep '^[a-zA-Z\-]\{10\}+')"

if [ -z "$checkfiles" ]; then
 echo "NO User home directories have ACLs" >> $Results
 echo "Pass" >> $Results
else
 echo "User Home directories have been found with ACLs" >> $Results
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
fi
