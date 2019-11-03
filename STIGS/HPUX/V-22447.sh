#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#SNMP Versions 1 and 2 are not considered secure. Without the strong authentication and privacy that is provided by the SNMP Version 3 User-based Security Model (USM), an attacker or other unauthorized users may gain access to detailed system management information and use that information to launch attacks against the system.

#STIG Identification
GrpID="V-22447"
GrpTitle="GEN005305"
RuleID="SV-26716r1_rule"
STIGID="GEN005305"
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

if [ -e /etc/SnmpAgent.d/snmpd.conf ]; then
 if egrep -i "get-community-name|set-community-name" /etc/SnmpAgent.d/snmpd.conf | grep -v "^#" >> $Results; then
  echo "Configuration Found" >> $Results
  echo "Fail" >> $Results
 else
  echo "No Community strings found" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/etc/SnmpAgent.d/snmpd.conf does not exist" >> $Results
 echo "Pass" >> $Results
fi