#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If critical system files do not have a privileged group-owner, system integrity could be compromised.

#STIG Identification
GrpID="V-4278"
GrpTitle="GEN006360"
RuleID="SV-35126r1_rule"
STIGID="GEN006360"
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
 check="$(find /var/news -type f \( ! -group root -o ! -group news \) 2>>/dev/null)"
 echo "$check" >> $Results
 if [ -n "$check" ]; then
  echo "Fail" >> $Results 
 else
  echo "All files owned by root or news" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/var/news doesn't exist" >> $Results
 echo "Pass" >> $Results
fi