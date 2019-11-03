#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#LDAP can be used to provide user authentication and account information, which are vital to system security. Communication between an LDAP server and a host using LDAP requires protection.

#STIG Identification
GrpID="V-22555"
GrpTitle="GEN007980"
RuleID="SV-41996r1_rule"
STIGID="GEN007980"
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

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 if grep "^enable_startTLS=1" /etc/opt/ldapux/ldapux_client.conf >> $Results; then
  if /opt/ldapux/contrib/bin/certutil -L -d /etc/opt/ldapux >> $Results; then
   echo "Pass" >> $Results
  else
   echo "CA Certificate not found" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "TLS Setting not found" >> $Results
  echo "Fail" >> $Results	 
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi