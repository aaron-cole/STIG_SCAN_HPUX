#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Guest access to shares permits anonymous access and is not permitted.

#STIG Identification
GrpID="V-22501"
GrpTitle="GEN006235"
RuleID="SV-35112r1_rule"
STIGID="GEN006235"
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
  if grep -i "^guest ok = yes" /etc/opt/samba/smb.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -v "^#" >> $Results; then
   echo "Fail" >> $Results
  else
   echo "Guest setting not set - not a finding" >> $Results
   echo "Pass" >> $Results
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