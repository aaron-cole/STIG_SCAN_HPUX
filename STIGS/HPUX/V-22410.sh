#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Responding to broadcast Internet Control Message Protocol (ICMP) echoes facilitates network mapping and provides a vector for amplification attacks.

#STIG Identification
GrpID="V-22410"
GrpTitle="GEN003603"
RuleID="SV-35025r1_rule"
STIGID="GEN003603"
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

ndd -get /dev/ip ip_respond_to_echo_broadcast >> $Results

if [ "$(ndd -get /dev/ip ip_respond_to_echo_broadcast)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi