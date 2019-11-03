#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If informational and more severe SMTP service messages are not logged, malicious activity on the system may go unnoticed.

#STIG Identification
GrpID="V-836"
GrpTitle="GEN004460"
RuleID="SV-35051r1_rule"
STIGID="GEN004460"
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

if grep -v "^#" /etc/syslog.conf | grep "mail.crit" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "mail.\*" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "mail.debug" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "\*.\*" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "\*.crit" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "\*.debug" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
else
 echo "No Mail Logging was found in /etc/syslog.conf" >> $Results
 echo "Fail" >> $Results
fi
