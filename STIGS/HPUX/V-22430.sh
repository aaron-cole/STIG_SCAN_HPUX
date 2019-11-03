#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The portmap and rpcbind services increase the attack surface of the system and should only be used when needed. The portmap or rpcbind services are used by a variety of services using Remote Procedure Calls (RPCs).

#STIG Identification
GrpID="V-22430"
GrpTitle="GEN003815"
RuleID="SV-35088r1_rule"
STIGID="GEN003815"
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

rcpinfo -p >> $Results 2>>/dev/null

if rpcinfo -p | grep mountd >> /dev/null; then
 echo "rpc is required by the server" >> $Results
 echo "Pass" >> $Results
else
 echo "rpc is required by swinstall" >> $Results
 echo "Pass" >> $Results
fi