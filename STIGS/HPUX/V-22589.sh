#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#System package management tools can obtain a list of updates and patches from a package repository and make this information available to the SA for review and action. Using a package repository outside of the organization's control presents a risk that malicious packages could be introduced.

#STIG Identification
GrpID="V-22589"
GrpTitle="GEN008820"
RuleID="SV-38405r1_rule"
STIGID="GEN008820"
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

if grep "swa" /var/spool/cron/crontabs/* >> $Results 2>>/dev/null; then
 echo "SWA found in crontabs" >> $Results
 echo "Fail" >> $Results
elif grep "swa" /var/spool/cron/atjobs/* >> $Results 2>>/dev/null; then
 echo "SWA found in atjobs" >> $Results
 echo "Fail" >> $Results
else
 echo "SWA is not configured with cron or at" >> $Results
 echo "Pass" >> $Results
fi
