#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The umask controls the default access mode assigned to newly created files.  An umask of 077 limits new files to mode 700 or less permissive.  Although umask is often represented as a 4-digit number, the first digit representing special access modes is typically ignored or required to be 0.

#STIG Identification
GrpID="V-4366"
GrpTitle="GEN003440"
RuleID="SV-34996r1_rule"
STIGID="GEN003440"
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

if [ "$(ls /var/spool/cron/atjobs)" ]; then
 echo "Manual Check" >> $Results
 echo "Fail" >> $Results
else
 echo "No AT jobs present" >> $Results
 echo "NA" >> $Results
fi
