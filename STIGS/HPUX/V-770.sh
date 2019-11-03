#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If an account is configured for password authentication but does not have an assigned password, it may be possible to log into the account without authentication. If the root user is configured without a password, the entire system may be compromised. For user accounts not using password authentication, the account must be configured with a password lock value instead of a blank or null value. 

#STIG Identification
GrpID="V-770"
GrpTitle="GEN000560"
RuleID="SV-38448r2_rule"
STIGID="GEN000560"
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
 if grep "u_pwd=::" /tcb/files/auth/*/* >> $Results; then
  echo "Fail" >> $Results
 else
  echo "No accounts have blank passwords" >> $Results
  echo "Pass" >> $Results
 fi
#For SMSE mode
else 
 if cut -f 2 -d ":" /etc/passwd | grep "^$" >> /dev/null; then
  echo "Blank Passwords found in /etc/shadow" >> $Results
  echo "Fail" >> $Results
 else
  echo "Blank Passwords NOT found in /etc/shadow" >> $Results
  echo "Pass" >> $Results
 fi
fi