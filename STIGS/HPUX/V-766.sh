#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Disabling accounts after a limited number of unsuccessful login attempts improves protection against password guessing attacks.

#STIG Identification
GrpID="V-766"
GrpTitle="GEN000460"
RuleID="SV-38445r3_rule"
STIGID="GEN000460"
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
###########################
#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 if grep ':u_maxtries#3:' /tcb/files/auth/system/default >> $Results; then
  echo "Pass" >> $Results
 else 
  grep 'maxtries' /tcb/files/auth/system/default >> $Results
  echo "Fail" >> $Results
 fi
#For SMSE mode
else 
 if grep "^AUTH_MAXTRIES=2" /etc/default/security >> $Results; then
  echo "Pass" >> $Results
 else
  grep "^AUTH_MAXTRIES" /etc/default/security >> $Results
  echo "Fail" >> $Results
 fi
fi