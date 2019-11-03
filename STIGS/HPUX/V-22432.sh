#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The rlogind process provides a typically unencrypted, host-authenticated remote access service. SSH should be used in place of this service.

#STIG Identification
GrpID="V-22432"
GrpTitle="GEN003830"
RuleID="SV-29697r1_rule"
STIGID="GEN003830"
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

grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep "rlogind" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -c "rlogind")" != 0 ]; then
 echo "rlogind service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "rlogind service is not found" >> $Results 
 echo "Pass" >> $Results
fi