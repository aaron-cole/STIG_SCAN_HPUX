#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If access attempts are not logged, then multiple attempts to log on to the system by an unauthorized user may go undetected.

#STIG Identification
GrpID="V-941"
GrpTitle="GEN006600"
RuleID="SV-35206r2_rule"
STIGID="GEN006600"
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

if grep -v "^#" /etc/syslog.conf | grep "mail.info" >> $Results; then
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
elif grep -v "^#" /etc/syslog.conf | grep "\*.info" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/syslog.conf | grep "\*.debug" >> $Results; then
 echo "Mail logging is enabled" >> $Results
 echo "Pass" >> $Results
else
 echo "No Mail Logging was found in /etc/syslog.conf" >> $Results
 echo "Fail" >> $Results
fi