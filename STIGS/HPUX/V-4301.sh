#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-4301"
GrpTitle="GEN000240"
RuleID="SV-38428r1_rule"
STIGID="GEN000240"
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

if ntpq -p | grep "^*" >> $Results; then
 echo "NTP is being used" >> $Results
 echo "Pass" >> $Results
elif crontab -l | grep ntpdate | grep -v "^#" >> $Results; then
 echo "crontab ntpdate entry found" >> $Results
 echo "Pass" >> $Results
else
 echo "Fail" >> $Results
fi

