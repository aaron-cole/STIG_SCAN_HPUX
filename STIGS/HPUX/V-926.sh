#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the NIS+ server is not operating in, at least, security level 2, there is no encryption and the system could be penetrated by intruders and/or malicious users.

#STIG Identification
GrpID="V-926"
GrpTitle="GEN006460"
RuleID="SV-38537r1_rule"
STIGID="GEN006460"
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

if grep -v "^#" /etc/nsswitch.conf | egrep "nisplus" >> $Results; then
 if niscat cred.org_dir | grep DES >> $Results; then
  echo "System is using NIS+ and using security level two" >> $Results
  echo "Pass" >> $Results
 else
  echo "System is Not using NIS+ and using security level two" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "System is not using NIS+"  >> $Results
 echo "NA" >> $Results
fi