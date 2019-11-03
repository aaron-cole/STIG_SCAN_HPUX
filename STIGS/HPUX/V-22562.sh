#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security.  The LDAP client configuration must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22562"
GrpTitle="GEN008120"
RuleID="SV-29569r1_rule"
STIGID="GEN008120"
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
file="/etc/opt/ldapux/ldapux_client.conf"

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 if [ -e $file ]; then
  ls -lLd $file >> $Results
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   echo "Fail" >> $Results
  else
   echo "Pass"  >> $Results
  fi
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi