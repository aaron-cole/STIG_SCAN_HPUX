#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22506"
GrpTitle="GEN006565"
RuleID="SV-35166r1_rule"
STIGID="GEN006565"
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

if crontab -l | grep -v "^#" | grep "/usr/sbin/swverify" >> $Results; then
 echo "System Package Management tool is verifing integrity of packages" >> $Results
 echo "Pass" >> $Results
else
 echo "System Package Management tool is not verifing integrity of packages" >> $Results
 echo "Fail" >> $Results
fi
