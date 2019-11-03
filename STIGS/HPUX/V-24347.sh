#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-24347"
GrpTitle="GEN009120"
RuleID="SV-38412r2_rule"
STIGID="GEN009120"
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

if ps -ef | grep -v grep | grep ldap >> $Results; then
 if grep "^passwd" /etc/nsswitch.conf | grep "ldap" >> $Results; then
  if grep "^AuthorizedKeysCommand " /etc/opt/ssh/sshd_config >> $Results; then
   echo "Users are using Red Hat Identity Manager to CAC/ALT logins" >> $Results
   echo "Pass" >> $Results
  else
   echo "Is this a standalone system or Test system with Interim Approval?" >> $Results
   echo "This is a manual check" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "Is this a standalone system or Test system with Interim Approval?" >> $Results
  echo "This is a manual check" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "Is this a standalone system or Test system with Interim Approval?" >> $Results
 echo "This is a manual check" >> $Results
 echo "Fail" >> $Results
fi