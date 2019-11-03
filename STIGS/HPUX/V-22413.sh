#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Source-routed packets allow the source of the packet to suggest routers forward the packet along a different path than configured on the router, which can be used to bypass network security measures.

#STIG Identification
GrpID="V-22413"
GrpTitle="GEN003606"
RuleID="SV-29707r2_rule"
STIGID="GEN003606"
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
ipfstat -o 2>>/dev/null | egrep "lsrr|ssrr" >> $Results 

if [ "$(ipfstat -o 2>>/dev/null | grep "block out log" | grep "with opt lsrr$" | wc -l)" -ge 1 ] && [ "$(grep "^block out log" /etc/opt/ipf/ipf.conf 2>>/dev/null| grep "with opt lsrr$" | wc -l)" -ge 1 ]; then
 echo "IPF is configured to prevent lsrr outbound generated source-routed packets" >> $Results
 if [ "$(ipfstat -o 2>>/dev/null | grep "block out log" | grep "with opt ssrr$" | wc -l)" -ge 1 ] && [ "$(grep "^block out log" /etc/opt/ipf/ipf.conf 2>>/dev/null| grep "with opt ssrr$" | wc -l)" -ge 1 ]; then
  echo "IPF is configured to prevent ssrr outbound generated source-routed packets" >> $Results
  echo "Pass" >> $Results 
 else
  echo "IPF is NOT configured to prevent outbound ssrr generated source-routed packets" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "IPF is NOT configured to prevent lsrr outbound generated source-routed packets" >> $Results
 echo "Fail" >> $Results
fi