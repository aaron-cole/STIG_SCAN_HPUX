#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a system has no default gateway defined, the system is at increased risk of man-in-the-middle, monitoring, and Denial of Service attacks.

#STIG Identification
GrpID="V-22490"
GrpTitle="GEN005570"
RuleID="SV-26805r1_rule"
STIGID="GEN005570"
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
 if netstat -f inet6 -r | grep default >> $Results; then
  echo "IPV6 in USE and Gateway is defined" >> $Results
  echo "Pass" >> $Results
 else
  echo "IPV6 in USE and Gateway is NOT defined" >> $Results
  echo "Fail" >> $Results
 fi
else
 grep "IPV6_INTERFACE\[0\]=" /etc/rc.config.d/netconf-ipv6 | grep -v "^#" >> $Results
 echo "System Does NOT use IPV6" >> $Results
 echo "Pass" >> $Results
fi
