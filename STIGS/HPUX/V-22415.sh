#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Proxy ARP allows a system to respond to ARP requests on one interface on behalf of hosts connected to another interface. If this function is enabled when not required, addressing information may be leaked between the attached network segments.

#STIG Identification
GrpID="V-22415"
GrpTitle="GEN003608"
RuleID="SV-29602r1_rule"
STIGID="GEN003608"
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

if ndd -get /dev/arp arp_cache_report | grep "PUBLISH" | grep -v "LOCAL" >> $Results; then
 echo "Non-local PUBLISHED entries found" >> $Results
 echo "Fail" >> $Results
else
 echo "NO Non-local PUBLISHED entries found" >> $Results
 ndd -get /dev/arp arp_cache_report | grep "PUBLISH" >> $Results
 echo "Pass" >> $Results
fi
 