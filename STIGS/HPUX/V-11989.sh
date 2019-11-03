#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#.rhosts files are used to specify a list of hosts permitted remote access to a particular account without authenticating. The use of such a mechanism defeats strong identification and authentication requirements.

#STIG Identification
GrpID="V-11989"
GrpTitle="GEN002100"
RuleID="SV-38264r2_rule"
STIGID="GEN002100"
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

if grep "^rcomds" /etc/pam.conf | egrep "auth|account" >> $Results; then
 echo "rexec services are configured" >> $Results
 echo "Fail" >> $Results
else
 echo "rexec services are NOT configured" >> $Results
 echo "Pass" >> $Results
fi