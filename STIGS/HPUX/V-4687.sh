#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The remshd process provides a typically unencrypted, host-authenticated remote access service.  SSH should be used in place of this service.

#STIG Identification
GrpID="V-4687"
GrpTitle="GEN003820"
RuleID="SV-35130r1_rule"
STIGID="GEN003820"
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

grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep "remshd" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -c "remshd")" != 0 ]; then
 echo "remshd service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "remshd service is not found" >> $Results 
 echo "Pass" >> $Results
fi