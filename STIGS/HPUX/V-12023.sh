#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the system is configured for IP forwarding and is not a designated router, it could be used to bypass network security by providing a path for communication not filtered by network devices.

#STIG Identification
GrpID="V-12023"
GrpTitle="GEN005600"
RuleID="SV-35177r1_rule"
STIGID="GEN005600"
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

ndd -get /dev/ip ip_forwarding >> $Results

if [ "$(ndd -get /dev/ip ip_forwarding )" -eq 0 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi