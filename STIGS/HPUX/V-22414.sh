#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Source-routed packets allow the source of the packet to suggest routers forward the packet along a different path than configured on the router, which can be used to bypass network security measures. This requirement applies only to the handling of source-routed traffic destined to the system itself, not to traffic forwarded by the system to another, such as when IPv4 forwarding is enabled and the system is functioning as a router.

#STIG Identification
GrpID="V-22414"
GrpTitle="GEN003607"
RuleID="SV-29713r2_rule"
STIGID="GEN003607"
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
ipfstat -i 2>>/dev/null | egrep "lsrr|ssrr" >> $Results 

if [ "$(ipfstat -i 2>>/dev/null | grep "block in log" | grep "with opt lsrr$" | wc -l)" -ge 1 ] && [ "$(grep "^block in log" /etc/opt/ipf/ipf.conf 2>>/dev/null| grep "with opt lsrr$" | wc -l)" -ge 1 ]; then
 echo "IPF is configured to prevent lsrr incoming generated source-routed packets" >> $Results
 if [ "$(ipfstat -i 2>>/dev/null | grep "block in log" | grep "with opt ssrr$" | wc -l)" -ge 1 ] && [ "$(grep "^block in log" /etc/opt/ipf/ipf.conf 2>>/dev/null| grep "with opt ssrr$" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to prevent ssrr incoming generated source-routed packets" >> $Results
  echo "Pass" >> $Results 
 else
  echo "IPF is NOT configured to prevent ssrr incoming generated source-routed packets" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "IPF is NOT configured to prevent lsrr incoming generated source-routed packets" >> $Results
 echo "Fail" >> $Results
fi