#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/pam_user.conf file is the per user configuration file for the Pluggable Authentication Module (PAM) architecture. It supports per user authentication, account, session, and password management. If the configuration is modified maliciously, users may gain unauthorized system access. The /etc/pam_user.conf file must not be configured unless it is required.

#STIG Identification
GrpID="V-40487"
GrpTitle="GEN000000-HPUX0440"
RuleID="SV-52476r1_rule"
STIGID="GEN000000-HPUX0440"
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
#File or Directory to check
file="/etc/pam_user.conf"

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 echo "Not Applicable for Trusted Mode Systems"  >> $Results
 echo "NA" >> $Results
else
# findACLHFS="$(find $file -acl opt)"
# findACLvxfs="$(find $file -aclv opt)"
 fileACL="$(getacl $file)"
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo $fileACL >> $Results
  echo "Fail" >> $Results
 else
  echo $fileACL >> $Results
  echo "Pass"  >> $Results
 fi
fi