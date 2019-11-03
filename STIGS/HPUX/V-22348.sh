#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Group passwords are typically shared and should not be used.  Additionally, if password hashes are readable by non-administrators, the passwords are subject to attack through lookup tables or cryptographic weaknesses in the hashes.

#STIG Identification
GrpID="V-22348"
GrpTitle="GEN001475"
RuleID="SV-38341r1_rule"
STIGID="GEN001475"
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

if cut -f 2,2 -d ":" /etc/group | egrep -v "^$|\*" >> $Results; then
 echo "Passwords defined in /etc/group" >> $Results
 echo "Fail" >> $Results
else
 echo "Passwords are not defined in /etc/group" >> $Results
 echo "Pass" >> $Results
fi
