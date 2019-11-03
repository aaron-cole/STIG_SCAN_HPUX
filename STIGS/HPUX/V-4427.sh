#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If these files are not properly configured, they could allow malicious access by unknown malicious users from untrusted hosts who could compromise the system.

#STIG Identification
GrpID="V-4427"
GrpTitle="GEN002020"
RuleID="SV-38438r1_rule"
STIGID="GEN002020"
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
answerfile="./Results/prestage"

if [ -e "$answerfile" ]; then
 if [ "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")" != "" ]; then
  echo "Manual Check required" >> $Results
  echo "Fail" >> $Results
 else
  echo "No rhost/shosts/host.equiv/shosts.equiv files found" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "Fail" >> $Results
fi