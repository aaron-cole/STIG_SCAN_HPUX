#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the system's access control program is not configured with appropriate rules for allowing and denying access to system network resources, services may be accessible to unauthorized hosts.

#STIG Identification
GrpID="V-12030"
GrpTitle="GEN006620"
RuleID="SV-35222r1_rule"
STIGID="GEN006620"
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

if [ ! -f /etc/hosts.allow ]; then
 echo "/etc/hosts.allow doesn't exist" >> $Results
 echo "Fail" >> $Results
elif [ ! -f /etc/hosts.deny ]; then
 echo "/etc/hosts.deny doesn't exist" >> $Results
 echo "Fail" >> $Results
else
 if grep -v "^#" /etc/hosts.deny | egrep "ALL:ALL" >> $Results; then
  echo "Required Entry found in /etc/hosts.deny" >> $Results
  echo "Pass" >> $Results
 else
  echo "Required Entry NOT found in /etc/hosts.deny" >> $Results
  echo "Fail" >> $Results
 fi
fi
