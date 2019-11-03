#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The SMTP service version on the system must be current to avoid exposing vulnerabilities present in unpatched versions.

#STIG Identification
GrpID="V-4689"
GrpTitle="GEN004600"
RuleID="SV-35065r2_rule"
STIGID="GEN004600"
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

strings /usr/sbin/sendmail | grep "Sendmail version" >> $Results
VERSION="$(strings /usr/sbin/sendmail | grep "Sendmail version" | awk '{print $3}')"

if [ "$(echo $VERSION | cut -f 1 -d ".")" -gt 8 ]; then
 echo "Pass" >> $Results
elif [ "$(echo $VERSION | cut -f 1 -d ".")" -eq 8 ]; then
 if [ "$(echo $VERSION | cut -f 2 -d ".")" -gt 14 ]; then
  echo "Pass" >> $Results
 elif [ "$(echo $VERSION | cut -f 2 -d ".")" -eq 14 ]; then
  if [ "$(echo $VERSION | cut -f 3 -d ".")" -ge 4 ]; then
   echo "Pass" >> $Results
  else
   echo "Fail" >> $Results
  fi
 else
  echo "Fail" >> $Results
 fi
else
 echo "Fail" >> $Results
fi
