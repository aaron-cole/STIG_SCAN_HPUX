#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The processing of ICMP timestamp requests increases the attack surface of the system. Responding to broadcast ICMP timestamp requests facilitates network mapping and provides a vector for amplification attacks.

#STIG Identification
GrpID="V-22411"
GrpTitle="GEN003604"
RuleID="SV-35026r1_rule"
STIGID="GEN003604"
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

ndd -get /dev/ip ip_respond_to_timestamp_broadcast >> $Results

if [ "$(ndd -get /dev/ip ip_respond_to_timestamp_broadcast)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi