#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If TFTP has a valid shell, it increases the likelihood that someone could logon to the TFTP account and compromise the system.

#STIG Identification
GrpID="V-849"
GrpTitle="GEN005120"
RuleID="SV-35157r1_rule"
STIGID="GEN005120"
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

if [ "$(grep -v "^#" /etc/inetd.conf | grep -c -i tftp)" != 0 ]; then
 if grep "^tftp:" /etc/passwd >> $Results ; then 
  if grep "^tftp:" /etc/passwd | cut -f 7 -d ":" | egrep "false|null|nologin" >> /dev/null; then
   echo "tftp user account shell set correctly" >> $Results
   echo "Pass" >> $Results
  else
   echo "tftp user account shell does not appear to be set correctly" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "tftp is enabled and no user account exists" >> $Results
  echo "Fail" >> $Results 
 fi
else
 echo "tftp service is not enabled" >> $Results 
 echo "Pass" >> $Results
fi