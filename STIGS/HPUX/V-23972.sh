#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Responding to broadcast ICMP echo requests facilitates network mapping and provides a vector for amplification attacks.

#STIG Identification
GrpID="V-23972"
GrpTitle="GEN007950"
RuleID="SV-29786r1_rule"
STIGID="GEN007950"
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
 if [ "$(ipfstat -6 -i 2>>/dev/null| grep "block in " | grep "from any to ff02::1 icmpv6-type 128" | wc -l)" -ge 1 ] && [ "$(grep "^block in " /etc/opt/ipf/ipf6.conf| grep "from any to ff02::1 icmpv6-type 128" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to block inbound IPV6 ICMP echo requests" >> $Results
  echo "Pass" >> $Results 
 else
  echo "IPF is NOT configured to block inbound IPV6 ICMP echo requests" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "IPV6 is not in use" >> $Results
 grep "IPV6_INTERFACE\[0\]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" >> $Results
 echo "Pass" >> $Results
fi
