#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Best practices and standard operating procedures for computing systems include password management. If the root account is allowed to be configured with inadequate password controls, the entire system can be compromised.

#STIG Identification
GrpID="V-50999"
GrpTitle="GEN000000-HPUX0225"
RuleID="SV-65205r2_rule"
STIGID="GEN000000-HPUX0225"
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
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
#For SMSE
 grep "PASSWORD_POLICY_STRICT" /etc/default/security >> $Results
 if [ "$(grep "PASSWORD_POLICY_STRICT" /etc/default/security | grep -v "^#" | cut -f 2 -d "=")" = "1" ]; then
  echo "Pass" >> $Results
 else
  echo "Fail" >> $Results
 fi
fi