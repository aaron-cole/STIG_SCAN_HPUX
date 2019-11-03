#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File integrity tools often use cryptographic hashes for verifying file contents have not been altered. These hashes must be FIPS 140-2 approved.

#STIG Identification
GrpID="V-22509"
GrpTitle="GEN006575"
RuleID="SV-35194r1_rule"
STIGID="GEN006575"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###

if ps -ef | grep -i tripwire | grep -v grep >> $Results; then
 echo "Tripwire installed and Running" >> $Results
 echo "Pass" >> $Results
else
 echo "Tripwire is not installed and running" >> $Results
 echo "What other file integrity tool is used?" >> $Results
 echo "Fail" >> $Results 
fi