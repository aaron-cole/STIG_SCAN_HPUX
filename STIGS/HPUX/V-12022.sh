#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The SSH daemon must be configured for IP filtering to provide a layered defense against connection attempts from unauthorized addresses.

#STIG Identification
GrpID="V-12022"
GrpTitle="GEN005540"
RuleID="SV-35149r1_rule"
STIGID="GEN005540"
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

if grep -v "^#" /etc/hosts.allow | grep -i sshd >> $Results; then
 echo "TCP Wrappers are configured for sshd in /etc/hosts.allow" >> $Results
 echo "Pass" >> $Results
elif grep -v "^#" /etc/hosts.deny | grep -i sshd >> $Results; then
 echo "TCP Wrappers are configured for sshd in /etc/hosts.deny" >> $Results
 echo "Pass" >> $Results
else
 echo "Required SSHD Entry NOT found in /etc/hosts.deny or /etc/hosts.allow" >> $Results
 echo "Fail" >> $Results
fi