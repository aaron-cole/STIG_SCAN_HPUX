#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The umask controls the default access mode assigned to newly created files. An umask of 0077 limits new files to mode 0700 or less permissive. The leading zero digit represents an unsigned octal integer. This requirement applies to the globally configured system and user account defaults for all sessions initiated via PAM.

#STIG Identification
GrpID="V-40494"
GrpTitle="GEN000000-HPUX0470"
RuleID="SV-52483r1_rule"
STIGID="GEN000000-HPUX0470"
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
###########################
grep "UMASK" /etc/default/security | grep -v "^#" >> $Results
if [ "$(grep "UMASK" /etc/default/security | grep -v "^#" | cut -f 2 -d "=")" = "0077" ]; then
  echo "Pass" >> $Results
else
  echo "Fail" >> $Results
fi