#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Source-routed packets allow the source of the packet to suggest routers forward the packet along a different path than configured on the router, which can be used to bypass network security measures. This requirement applies only to the forwarding of source-routed traffic, such as when IPv6 forwarding is enabled and the system is functioning as a router. 

#STIG Identification
GrpID="V-22553"
GrpTitle="GEN007920"
RuleID="SV-38378r1_rule"
STIGID="GEN007920"
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

ndd -get /dev/ip6 ip6_forwarding >> $Results

if [ "$(ndd -get /dev/ip6 ip6_forwarding)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi