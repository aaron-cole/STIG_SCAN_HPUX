#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The authentication of automated LDAP connections between systems must not use passwords since more secure methods are available, such as PKI and Kerberos. Additionally, the storage of unencrypted passwords on the system is not permitted.

#STIG Identification
GrpID="V-24384"
GrpTitle="GEN008050"
RuleID="SV-38414r1_rule"
STIGID="GEN008050"
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
scorecheck=0
files="/etc/opt/ldapux/acred /etc/opt/ldapux/pcred"

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 for file in $files; do
  if [ -f $file ]; then
   ((scorecheck+=1))
   echo "Fail - $file exists" >> $Results
  else
   echo "Pass - $file does not exist" >> $Results
  fi
 done
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
