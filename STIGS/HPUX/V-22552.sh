#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Reverse-path filtering provides protection against spoofed source addresses by causing the system to discard packets with source addresses for which the system has no route or if the route does not point towards the interface on which the packet arrived. Depending on the role of the system, reverse-path filtering may cause legitimate traffic to be discarded and, therefore, should be used with a more permissive mode or filter, or not at all. Whenever possible, reverse-path filtering should be used.

#STIG Identification
GrpID="V-22552"
GrpTitle="GEN007900"
RuleID="SV-42274r1_rule"
STIGID="GEN007900"
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


if [ "$(grep "IPV6_INTERFACE\[0\]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" | cut -f 2 -d "=" | wc -m)" -gt 3 ]; then
 ipfstat -6i 2>>/dev.null | grep "block in" | grep "from 0::1 to any" >> $Results
 if [ "$(ipfstat -6i 2>>/dev.null | grep "block in" | grep "from 0::1 to any" | wc -l)" -ge 1 ]; then
  echo "IPF6 is configured to block inbound traffic to loopback adddress" >> $Results
  echo "Pass" >> $Results  
 else
  echo "IPF6 is NOT configured to block inbound traffic to loopback adddress" >> $Results
  echo "Fail" >> $Results
 fi
else
 grep "IPV6_INTERFACE[0]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" >> $Results
 echo "IPV6 is disabled on the Machine per HPs recommended way" >> $Results
 echo "Check is NA" >> $Results
 echo "NA" >> $Results
fi