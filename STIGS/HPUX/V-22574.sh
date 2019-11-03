#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security.  The LDAP client configuration must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22574"
GrpTitle="GEN008360"
RuleID="SV-38397r1_rule"
STIGID="GEN008360"
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
file="/etc/opt/ldapux/key3.db"

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