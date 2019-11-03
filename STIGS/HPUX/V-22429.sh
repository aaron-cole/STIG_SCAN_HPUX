#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The portmap and rpcbind services increase the attack surface of the system and should only be used when needed. The portmap or rpcbind services are used by a variety of services using Remote Procedure Calls (RPCs).

#STIG Identification
GrpID="V-22429"
GrpTitle="GEN003810"
RuleID="SV-26665r1_rule"
STIGID="GEN003810"
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

if ps -ef | grep -v grep | grep rpcbind >> $Results; then
 if [ "$(rpcinfo -p | wc -l)" -ge 2 ]; then
  echo "rpc is required by the server, check is NA" >> $Results
  echo "NA" >> $Results
 else
  echo "rpc appears to not be required and is running" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "rpcbind is not running" >> $Results
 echo "Pass" >> $Results
fi
