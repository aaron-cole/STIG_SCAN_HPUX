#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Systems must employ cryptographic hashes for passwords using the SHA-2 family of algorithms or FIPS 140-2 approved successors.  The use of unapproved algorithms may result in weak password hashes that are more vulnerable to compromise.

#STIG Identification
GrpID="V-22304"
GrpTitle="GEN000595"
RuleID="SV-52491r2_rule"
STIGID="GEN000595"
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
 if egrep ":u_pwd" /tcb/files/auth/*/* | egrep -v ':u_pwd=\*|:u_pwd="\$6|:u_pwd=\$6' >> $Results; then
  echo "System is in Trusted Mode and there is no Fix per STIG"  >> $Results
  echo "Fail" >> $Results
 else
  echo "System is in Trusted Mode, but no non-compliant passwords found" >> $Results
  echo "Pass" >> $Results
 fi
else
#For SMSE
 if cut -f 2 -d ":" /etc/shadow | egrep -v "^\$6|^\*|^\!\!" >> $Results; then
  echo "Password hashes are found without a leading dollar sign 6 " >> $Results
  echo "Fail" >> $Results
 else
  echo "NO Password hashes are found without a leading dollar sign 6" >> $Results
  echo "Pass" >> $Results
 fi
fi