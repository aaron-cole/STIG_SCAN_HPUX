#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Routing protocol daemons are typically used on routers to exchange network topology information with other routers.  If this software is used when not required, system network information may be unnecessarily transmitted across the network.

#STIG Identification
GrpID="V-22665"
GrpTitle="GEN005590"
RuleID="SV-35164r1_rule"
STIGID="GEN005590"
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

if ps -ef | grep -v grep | egrep -i "route|ospf|bgp|zebra|quagga|ripng|ramd" >> $Results; then
 echo "Routing Protocols appear to be found" >> $Results
 echo "Review to see if true" >> $Results
 echo "Fail" >> $Results
else
 echo "No Routing Protocols found" >> $Results
 echo "Pass" >> $Results
fi
 
