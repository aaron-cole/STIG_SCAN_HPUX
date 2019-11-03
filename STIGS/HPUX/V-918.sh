#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-918"
GrpTitle="GEN000760"
RuleID="SV-38500r2_rule"
STIGID="GEN000760"
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
 if logins -o -a -r local | awk -F: '{print $1,$6}' | grep " [3-9][6-9].*" >> $Results; then
  echo "Inactivity is set wrong" >> $Results
  echo "Make sure none of these are application accts as this check only applies to user accounts" >> $Results
  echo "Fail" >> $Results
 else
  echo "All users have Inactivity set to 35 days or less" >> $Results
  logins -o -a -r local | awk -F: '{print $1,$6}' >> $Results
  echo "Pass" >> $Results
 fi
else
#For SMSE
 if grep INACTIVITY_MAXDAYS /etc/default/security /var/adm/userdb/* | egrep "=0|=35|[3-9][6-9].*" >> $Results; then
  echo "Users Inactivity is set wrong" >> $Results
  echo "Fail" >> $Results
 else
  echo "All users have Inactivity set to 35 days or less" >> $Results
  echo "Pass" >> $Results
 fi
fi