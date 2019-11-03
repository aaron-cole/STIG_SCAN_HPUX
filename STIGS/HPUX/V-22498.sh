#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the permissions of the smbpasswd file are too permissive, the smbpasswd file may be maliciously accessed or modified, potentially resulting in the compromise of Samba accounts.

#STIG Identification
GrpID="V-22498"
GrpTitle="GEN006210"
RuleID="SV-35105r1_rule"
STIGID="GEN006210"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
file="$(find /etc /opt /usr /var -type f -name smbpasswd 2>/dev/null)"

if [ -n "$file" ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi