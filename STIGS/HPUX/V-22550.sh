#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#ICMP redirect messages are used by routers to inform hosts of a more direct route existing for a particular destination. These messages modify the host's route table and are unauthenticated. An illicit ICMP redirect message could result in a man-in-the-middle attack.

#STIG Identification
GrpID="V-22550"
GrpTitle="GEN007860"
RuleID="SV-35241r1_rule"
STIGID="GEN007860"
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

#Is IPV6 in use?
if [ "$(grep "IPV6_INTERFACE\[0\]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" | cut -f 2 -d "=" | wc -m)" -gt 3 ]; then
 ipfstat -6 -i 2>>/dev/null | grep "icmpv6-type 137" >> $Results
 if [ "$(ipfstat -6 -i 2>>/dev/null | grep "block in " | grep "from any to any icmpv6-type 137" | wc -l)" -ge 1 ] && [ "$(grep "^block in " /etc/opt/ipf/ipf6.conf| grep "from any to any icmpv6-type 137" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to block inbound IPV6 ICMP redirects" >> $Results
  echo "Pass" >> $Results 
 else
  echo "IPF is NOT configured to block inbound IPV6 ICMP redirects" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "IPV6 is not in use" >> $Results
 grep "IPV6_INTERFACE\[0\]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" >> $Results
 echo "Pass" >> $Results
fi
