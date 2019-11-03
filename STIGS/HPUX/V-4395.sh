#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a remote log host is in use and it has not been justified and documented with the IAO, sensitive information could be obtained by unauthorized users without the SA's knowledge. A remote log host is any host to which the system is sending syslog messages over a network.

#STIG Identification
GrpID="V-4395"
GrpTitle="GEN005460"
RuleID="SV-35192r1_rule"
STIGID="GEN005460"
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

if grep "^.*@" /etc/syslog.conf | grep -v "^#" >> $Results; then
 echo "Remote log hosts found in syslog.conf" >> $Results
 echo "Ensure they are documented" >> $Results
 echo "Fail" >> $Results
else
 echo "Remote log hosts not found in syslog.conf" >> $Results
 echo "Pass" >> $Results
fi