#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system ACLs can provide access to files beyond what is allowed by the mode numbers of the files.

#STIG Identification
GrpID="V-22367"
GrpTitle="GEN002330"
RuleID="SV-38354r1_rule"
STIGID="GEN002330"
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