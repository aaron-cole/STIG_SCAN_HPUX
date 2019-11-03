#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-1023"
GrpTitle="GEN006240"
RuleID="SV-38236r1_rule"
STIGID="GEN006240"
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

if ps -ef | grep "nntpd" | grep -v grep >> $Results; then
 echo "nntpd is running" >> $Results
 echo "Fail" >> $Results
elif grep "^nntp" /etc/inetd.conf >> $Results; then
 echo "nntp configuration found in /etc/inetd.conf" >> $Results
 echo "Fail" >> $Results
else
 echo "nntp is completely disabled and INN cannot be ran" >> $Results
 echo "Pass" >> $Results
fi