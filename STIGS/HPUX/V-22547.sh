#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#IP tunneling mechanisms can be used to bypass network filtering.

#STIG Identification
GrpID="V-22547"
GrpTitle="GEN007820"
RuleID="SV-26928r1_rule"
STIGID="GEN007820"
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

if grep -v "^#" /etc/rc.config.d/netconf* | grep "TUN" >> $Results; then
 echo "Tunnel Configuration found" >> $Results
 echo "Fail" >> $Results
else
 echo "NO Tunnel Configuration found" >> $Results
 echo "Pass" >> $Results
fi