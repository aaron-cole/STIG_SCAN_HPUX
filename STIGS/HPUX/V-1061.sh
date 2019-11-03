#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-1061"
GrpTitle="GEN002360"
RuleID="SV-27252r1_rule"
STIGID="GEN002360"
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

if ioscan -f | grep "audio" >> $Results; then
 echo "Audio files found - manual check required" >> $Results
 echo "Manual" >> $Results
else
 echo "No Audio device files found" >> $Results
 echo "Pass" >> $Results
fi