#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Source-routed packets allow the source of the packet to suggest routers forward the packet along a different path than configured on the router, which can be used to bypass network security measures. This requirement applies only to the forwarding of source-routed traffic, such as when IPv4 forwarding is enabled and the system is functioning as a router.

#STIG Identification
GrpID="V-12002"
GrpTitle="GEN003600"
RuleID="SV-38259r1_rule"
STIGID="GEN003600"
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

ndd -get /dev/ip ip_forward_src_routed >> $Results

if [ "$(ndd -get /dev/ip ip_forward_src_routed)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi