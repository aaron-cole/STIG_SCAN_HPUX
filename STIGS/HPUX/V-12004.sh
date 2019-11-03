#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Monitoring and recording successful and unsuccessful logins assists in tracking unauthorized access to the system.

#STIG Identification
GrpID="V-12004"
GrpTitle="GEN003660"
RuleID="SV-35062r1_rule"
STIGID="GEN003660"
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

if grep -v "^#" /etc/syslog.conf | egrep -i "auth.info|auth.debug|auth.\*|\*.info|\*.debug" >> $Results; then
 echo "auth.info and auth.notice is properly being logged" >> $Results
 echo "Pass" >> $Results
else
 echo "auth.info and auth.notice ARE NOT properly being logged" >> $Results
 echo "Fail" >> $Results
fi
