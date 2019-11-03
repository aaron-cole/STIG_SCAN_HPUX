#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Samba is a tool used for the sharing of files and printers between Windows and UNIX operating systems.  It provides access to sensitive files and, therefore, poses a security risk if compromised.

#STIG Identification
GrpID="V-4321"
GrpTitle="GEN006060"
RuleID="SV-35208r1_rule"
STIGID="GEN006060"
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

if ps -ef | egrep "smbd" | grep -v "grep" >> $Results; then
 echo "Is Samba needed?  If so this is not a finding" >> $Results
 echo "Fail" >> $Results
else 
 echo "Samba is not running" >> $Results
 echo "Pass" >> $Results
fi