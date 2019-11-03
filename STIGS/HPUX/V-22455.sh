#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A syslog server (loghost) receives syslog messages from one or more systems. This data can be used as an authoritative log source in the event a system is compromised and its local logs are suspect.

#STIG Identification
GrpID="V-22455"
GrpTitle="GEN005450"
RuleID="SV-35189r1_rule"
STIGID="GEN005450"
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

grep -v "^#" /etc/syslog.conf | grep "\@" >> $Results

if grep -v "^#" /etc/syslog.conf | grep "\@" | awk '{print $2}' | grep "^\@" >> /dev/null; then
 echo "Syslogs are being sent to a remote server" >> $Results
 echo "Pass" >> $Results
else
 echo "Syslogs are NOT being sent to a remote server" >> $Results
 echo "Fail" >> $Results
fi
