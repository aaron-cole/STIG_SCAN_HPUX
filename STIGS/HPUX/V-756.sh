#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Single user mode access must be strictly limited to privileged users. The ability to boot to single user mode allows a malicious user the opportunity to modify, compromise, or otherwise damage the system.

#STIG Identification
GrpID="V-756"
GrpTitle="GEN000020"
RuleID="SV-38318r2_rule"
STIGID="GEN000020"
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
 if grep ":d_boot_authenticate:" /tcb/files/auth/system/default >> $Results; then
  echo "Pass" >> $Results
 else
  grep ":d_boot_authenticate:" /tcb/files/auth/system/default >> $Results
  echo "Fail" >> $Results
 fi
#For SMSE mode
else 
 if grep "BOOT_AUTH=1" /etc/default/security /var/adm/userdb/* >> $Results; then
  echo "Pass" >> $Results
 else
  grep "BOOT_AUTH=1" /etc/default/security /var/adm/userdb/* >> $Results
  echo "Fail" >> $Results
 fi
fi