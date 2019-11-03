#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The ability to change passwords frequently facilitates users reusing the same password. This can result in users effectively never changing their passwords. This would be accomplished by users changing their passwords when required and then immediately changing it to the original value.

#STIG Identification
GrpID="V-1032"
GrpTitle="GEN000540"
RuleID="SV-38199r2_rule"
STIGID="GEN000540"
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
 if logins -o -x -r local | awk -F: '{print $1,$10}' | grep -v " 1$" >> $Results; then
  echo "Users Password minimum days is set wrong" >> $Results
  echo "Fail" >> $Results
 else
  echo "All users have Password minimum days set to 1" >> $Results
  logins -o -x -r local | awk -F: '{print $1,$10}' >> $Results
  echo "Pass" >> $Results
 fi
else
#For SMSE
 if grep PASSWORD_MINDAYS /etc/default/security /var/adm/userdb/* | egrep -v "=1$|1" >> $Results; then
  echo "Users Password minimum days is set wrong" >> $Results
 else
  echo "All users have Password minimum days set to 1" >> $Results
  echo "Pass" >> $Results
 fi
fi