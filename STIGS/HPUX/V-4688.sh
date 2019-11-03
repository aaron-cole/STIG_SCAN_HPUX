#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The rexecd process provides a typically unencrypted, host-authenticated remote access service. SSH should be used in place of this service.

#STIG Identification
GrpID="V-4688"
GrpTitle="GEN003840"
RuleID="SV-35132r2_rule"
STIGID="GEN003840"
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

grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep "rexecd" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -c "rexecd")" != 0 ]; then
 echo "rexecd service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "rexecd service is not found" >> $Results 
 echo "Pass" >> $Results
fi