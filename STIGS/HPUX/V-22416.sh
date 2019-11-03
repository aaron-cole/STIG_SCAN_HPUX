#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#ICMP redirect messages are used by routers to inform hosts that a more direct route exists for a particular destination. These messages modify the host's route table and are unauthenticated. An illicit ICMP redirect message could result in a man-in-the-middle attack.

#STIG Identification
GrpID="V-22416"
GrpTitle="GEN003609"
RuleID="SV-29719r1_rule"
STIGID="GEN003609"
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
ipfstat -i 2>>/dev/null | grep "icmp-type redir" >> $Results

if [ "$(ipfstat -i 2>>/dev/null | grep "block in " | grep "proto icmp" | grep "icmp-type redir" | wc -l)" -ge 1 ] && [ "$(grep "^block in " /etc/opt/ipf/ipf.conf 2>>/dev/null | grep "proto icmp" | grep "icmp-type-redir" | wc -l)" -ge 1 ]; then
 echo "IPF is configured to block inbound IPv4 ICMP redirect" >> $Results
 echo "Pass" >> $Results 
else
 echo "IPF is NOT configured to block inbound IPv4 ICMP redirect" >> $Results
 echo "Fail" >> $Results
fi