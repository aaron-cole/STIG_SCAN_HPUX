#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unencrypted passwords for remote FTP servers may be stored in .netrc files. Policy requires passwords to be encrypted in storage and not used in access scripts.

#STIG Identification
GrpID="V-913"
GrpTitle="GEN002000"
RuleID="SV-38499r1_rule"
STIGID="GEN002000"
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
checkfiles="$(find / -name ".netrc" 2>>/dev/null)"

if [ -n "$checkfiles" ]; then
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
else 
 echo "No .netrc files found" >> $Results
 echo "Pass" >> $Results
fi