#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an account has an UID of 0, it has root authority. Multiple accounts with an UID of 0 afford more opportunity for potential intruders to compromise a privileged account.

#STIG Identification
GrpID="V-773"
GrpTitle="GEN000880"
RuleID="SV-38449r1_rule"
STIGID="GEN000880"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Checks 
grep ":0:" /etc/passwd | cut -f 1,3 -d ":" >> $Results

if [[ $(grep ":0:" /etc/passwd | wc -l) = 1 ]]; then
 echo "Pass"  >> $Results
else
 echo "Fail" >> $Results
fi