#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22302"
GrpTitle="GEN000585"
RuleID="SV-52487r1_rule"
STIGID="GEN000585"
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
 if egrep ":u_pwd" /tcb/files/auth/*/* | egrep -v ':u_pwd=\*|:u_pwd="\$|:u_pwd=\$' >> $Results; then
  echo "System is in Trusted Mode and there is no Fix per STIG"  >> $Results
  echo "Fail" >> $Results
 else
  echo "System is in Trusted Mode, but no non-compliant passwords found" >> $Results
  echo "Pass" >> $Results
 fi
else
#For SMSE
 if cut -f 2 -d ":" /etc/shadow | egrep -v "^\$|^\*|^\!\!" >> $Results; then
  echo "Password hashes are found without a leading dollar sign" >> $Results
  echo "Fail" >> $Results
 else
  echo "NO Password hashes are found without a leading dollar sign" >> $Results
  echo "Pass" >> $Results
 fi
fi
