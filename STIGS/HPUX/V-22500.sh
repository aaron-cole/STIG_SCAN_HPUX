#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Samba must be configured to protect authenticators.  If Samba passwords are not encrypted for storage, plain-text user passwords may be read by those with access to the Samba password file.

#STIG Identification
GrpID="V-22500"
GrpTitle="GEN006230"
RuleID="SV-35111r1_rule"
STIGID="GEN006230"
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

if swlist -l product | grep -i cifs | grep -i server >> $Results; then 
 if [ -e /etc/opt/samba/smb.conf ]; then
  if grep -i "^encrypt passwords = yes" /etc/opt/samba/smb.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" >> $Results; then
   echo "Pass" >> $Results
  else
   echo "Encrypt Passwords setting not set" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "CIFS is installed, but file does not exist in default location" >> $Results
  echo "Find the file in non-default location and check" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "Samba is not installed" >> $Results
 echo "Pass" >> $Results
fi