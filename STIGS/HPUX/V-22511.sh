#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The SCTP is an IETF-standardized transport layer protocol. This protocol is not yet widely used. Binding this protocol to the network stack increases the attack surface of the host. Unprivileged local processes may be able to cause the kernel to dynamically load a protocol handler by opening a socket using the protocol.

#STIG Identification
GrpID="V-22511"
GrpTitle="GEN007020"
RuleID="SV-29988r1_rule"
STIGID="GEN007020"
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

if swlist | grep -i SCTP >> $Results; then
 echo "SCTP is installed" >> $Results
 echo "Fail" >> $Results
else
 echo "SCTP is not installed" >> $Results
 echo "Pass" >> $Results
fi