#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The NSS LDAP service provides user mappings which are a vital component of system security.  Its configuration must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22567"
GrpTitle="GEN008220"
RuleID="SV-38390r1_rule"
STIGID="GEN008220"
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
file="/etc/opt/ldapux/cert8.db"

if grep -v "^#" /etc/nsswitch.conf | grep ldap >> $Results; then
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|2|root|bin) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
  esac
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using LDAP"  >> $Results
 echo "NA" >> $Results
fi