#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Enforcing a delay between consecutive failed login attempts increases protection against automated password guessing attacks.

#STIG Identification
GrpID="V-768"
GrpTitle="GEN000480"
RuleID="SV-38446r3_rule"
STIGID="GEN000480"
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
#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 grep t_logdelay /tcb/files/auth/system/default >> $Results
 if [ $(grep t_logdelay /tcb/files/auth/system/default | cut -f 2 -d ":" | cut -f2 -d "#") -ge 4 ]; then
  echo "Pass" >> $Results
 else
  echo "Fail" >> $Results
 fi
#For SMSE mode
else
 echo "Cannot be fixed in SMSE mode" >> $Results
 echo "Fail" >> $Results
fi