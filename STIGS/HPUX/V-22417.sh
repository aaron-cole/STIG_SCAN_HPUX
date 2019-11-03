#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#ICMP redirect messages are used by routers to inform hosts that a more direct route exists for a particular destination. These messages contain information from the system's route table possibly revealing portions of the network topology.

#STIG Identification
GrpID="V-22417"
GrpTitle="GEN003610"
RuleID="SV-35038r1_rule"
STIGID="GEN003610"
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

ndd -get /dev/ip ip_send_redirects >> $Results

if [ "$(ndd -get /dev/ip ip_send_redirects)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi