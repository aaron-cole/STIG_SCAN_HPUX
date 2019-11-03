#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The processing of ICMP timestamp requests increases the attack surface of the system.

#STIG Identification
GrpID="V-22409"
GrpTitle="GEN003602"
RuleID="SV-35022r1_rule"
STIGID="GEN003602"
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

ndd -get /dev/ip ip_respond_to_timestamp >> $Results

if [ "$(ndd -get /dev/ip ip_respond_to_timestamp)" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi