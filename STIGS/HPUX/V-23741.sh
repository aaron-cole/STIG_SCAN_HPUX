#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To provide some mitigation to TCP Denial of Service (DoS) attacks, the TCP backlog queue sizes must be set to at least 1280 or in accordance with product-specific guidelines.

#STIG Identification
GrpID="V-23741"
GrpTitle="GEN003601"
RuleID="SV-29690r1_rule"
STIGID="GEN003601"
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

ndd -get /dev/tcp tcp_syn_rcvd_max >> $Results

if [ "$(ndd -get /dev/tcp tcp_syn_rcvd_max)" -ge 1280 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi