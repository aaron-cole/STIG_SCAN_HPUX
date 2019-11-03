#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Direct login with the root account prevents individual user accountability. Acceptable non-routine uses of the root account for direct login are limited to emergency maintenance, the use of single-user mode for maintenance, and situations where individual administrator accounts are not available.

#STIG Identification
GrpID="V-11979"
GrpTitle="GEN001020"
RuleID="SV-38212r2_rule"
STIGID="GEN001020"
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
 /usr/lbin/getprpw -m audflg root >> $Results
 if [ "$(/usr/lbin/getprpw -m audflg root | cut -f 2 -d "=")" = "1" ]; then
  echo "Auditing is enabled for root" >> $Results
  if last root 2>>/dev/null | egrep -v "reboot|console|^$|^WTMPS_FILE" >> $Results; then
   echo "Direct logins found for root" >> $Results
   echo "Fail" >> $Results
  else
   echo "Direct logins NOT found for root" >> $Results
   echo "Pass" >> $Results
  fi
 else
  echo "Auditing is not enabled for root" >> $Results
  echo "Fail" >> $Results
 fi
else
#For SMSE
 if [ "$(grep AUDIT_FLAG /etc/default/security | cut -f 2 -d "=")" = "1" ]; then
 echo "Auditing is enabled for root" >> $Results
  if last root 2>>/dev/null | egrep -v "reboot|console^$|^WTMPS_FILE" >> $Results; then
   echo "Direct logins found for root" >> $Results
   echo "Fail" >> $Results
  else
   echo "Direct logins NOT found for root" >> $Results
   echo "Pass" >> $Results
  fi
 else
  echo "Auditing is not enabled for root" >> $Results
  echo "Fail" >> $Results
 fi
fi