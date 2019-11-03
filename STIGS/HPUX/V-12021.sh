#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unintentionally running a syslog server accepting remote messages puts the system at increased risk. Malicious syslog messages sent to the server could exploit vulnerabilities in the server software itself, could introduce misleading information in to the system's logs, or could fill the system's storage leading to a Denial of Service.

#STIG Identification
GrpID="V-12021"
GrpTitle="GEN005480"
RuleID="SV-35195r1_rule"
STIGID="GEN005480"
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

if grep "SYSLOGD_OPTS" /etc/rc.config.d/syslogd | grep -v "^#" | grep "\-N" >> $Results; then
 echo "Pass" >> $Results
else
 echo "Setting not found in /etc/rc.config.d/syslogd" >> $Results
 echo "Fail" >> $Results
fi