#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Inetd or xinetd logging and tracing allows the system administrators to observe the IP addresses connecting to their machines and to observe what network services are being sought. This provides valuable information when trying to find the source of malicious users and potential malicious users.

#STIG Identification
GrpID="V-1011"
GrpTitle="GEN003800"
RuleID="SV-35085r1_rule"
STIGID="GEN003800"
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

if ps -ef | grep -v grep | egrep -i "inetd|xinetd" >> /dev/null; then
 if ps -ef | grep -v grep | egrep -i "inetd -l|xinetd -l" >> $Results; then
  echo "Logging is enabled" >> $Results
  echo "Pass" >> $Results
 else
  echo "Logging is NOT enabled" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "inetd/xinetd is not running" >> $Results
 echo "Pass" >> $Results
fi