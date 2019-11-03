#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Accounts sharing a UID have full access to each others' files. This has the same effect as sharing a login. There is no way to assure identification, authentication, and accountability because the system sees them as the same user. If the duplicate UID is 0, this gives potential intruders another privileged account to attack.

#STIG Identification
GrpID="V-762"
GrpTitle="GEN000320"
RuleID="SV-38443r2_rule"
STIGID="GEN000320"
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

logins -d -r local >> $Results
if [ "$(logins -d -r local)" ]; then
  echo "Fail" >> $Results
else
  echo "Pass" >> $Results
fi