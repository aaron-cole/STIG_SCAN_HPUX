#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If password hashes are readable by non-administrators, the passwords are subject to attack through lookup tables or cryptographic weaknesses in the hashes.

#STIG Identification
GrpID="V-22347"
GrpTitle="GEN001470"
RuleID="SV-38323r2_rule"
STIGID="GEN001470"
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

if cut -f 2,2 -d ":" /etc/passwd | grep -v "\*" >> $Results; then
 echo "Passwords defined in /etc/password" >> $Results
 echo "Fail" >> $Results
else
 echo "Passwords are not defined in /etc/passwd" >> $Results
 echo "Pass" >> $Results
fi
