#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#One use of initial TCP sequence numbers is to verify bidirectional communication between two hosts, which provides some protection against spoofed source addresses being used by the connection originator. If the initial TCP sequence numbers for a host can be determined by an attacker, it may be possible to establish a TCP connection from a spoofed source address without bidirectional communication.

#STIG Identification
GrpID="V-12001"
GrpTitle="GEN003580"
RuleID="SV-35010r1_rule"
STIGID="GEN003580"
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

ndd -get /dev/tcp tcp_isn_passphrase >> $Results

if [ "$(ndd -get /dev/tcp tcp_isn_passphrase )" -eq 1 ]; then
 echo "Pass" >> $Results 
else
 echo "Setting not set or set incorrectly" >> $Results
 echo "Fail" >> $Results
fi