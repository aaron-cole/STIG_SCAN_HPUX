#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Single user mode access must be strictly limited to the privileged user root. The ability to boot to single user mode allows a malicious user the opportunity to modify, compromise, or otherwise damage the system.

#STIG Identification
GrpID="V-40446"
GrpTitle="GEN000000-HPUX0230"
RuleID="SV-52433r1_rule"
STIGID="GEN000000-HPUX0230"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Checks

if [ -f /tcb/files/auth/system/default ]; then
#For Trusted Mode
 grep ":u_bootauth:" /tcb/files/auth/[a-z,A-Z]/* >> $Results
 if grep ":u_bootauth:" /tcb/files/auth/[a-z,A-Z]/* | grep -v root >> /dev/null; then
  echo "No Users have this authority" >> $Results
  echo "Fail" >> $Results
 else
  echo "Pass" >> $Results
 fi
#For SMSE mode
else 
 if grep "BOOT_USERS" /etc/default/security /var/adm/userdb/* | grep -v root >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass" >> $Results
 fi 
fi