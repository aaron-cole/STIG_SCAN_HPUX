#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A unique user name is the first part of the identification and authentication process. If user names are not unique, there can be no accountability on the system for auditing purposes. Multiple accounts sharing the same name could result in the Denial of Service to one or both of the accounts or unauthorized access to files or privileges.

#STIG Identification
GrpID="V-761"
GrpTitle="GEN000300"
RuleID="SV-38442r2_rule"
STIGID="GEN000300"
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
if logins -u | sort | cut -f 1 -d " " | uniq -d >> $Results; then
  echo "Pass" >> $Results
else
  echo "Fail" >> $Results
fi