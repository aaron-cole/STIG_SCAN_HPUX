#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If critical system files are not owned by a privileged user, system integrity could be compromised.

#STIG Identification
GrpID="V-4277"
GrpTitle="GEN006340"
RuleID="SV-35122r1_rule"
STIGID="GEN006340"
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

if [ -e /var/news ]; then
 check="$(find /var/news -type f \( ! -user root -o ! -user news \) 2>>/dev/null)"
 echo "$check" >> $Results
 if [ -n "$check" ]; then
  echo "Fail" >> $Results 
 else
  echo "All files owned by root" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/var/news doesn't exist" >> $Results
 echo "Pass" >> $Results
fi