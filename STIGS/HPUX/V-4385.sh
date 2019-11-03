#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The .forward file allows users to automatically forward mail to another system. Use of .forward files could allow the unauthorized forwarding of mail and could potentially create mail loops which could degrade system performance.

#STIG Identification
GrpID="V-4385"
GrpTitle="GEN004580"
RuleID="SV-35061r1_rule"
STIGID="GEN004580"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

checkfiles="$(find / -type f -name ".forward")"

if [ -z "$checkfiles" ]; then
 echo "No .forward files found" >> $Results
 echo "Pass" >> $Results
else
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
fi