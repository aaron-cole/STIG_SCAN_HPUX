#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Whether active or not, default SNMP passwords, users, and passphrases must be changed to maintain security. If the service is running with the default authenticators, then anyone can gather data about the system and the network using the information to potentially compromise the integrity of the system or network(s).

#STIG Identification
GrpID="V-993"
GrpTitle="GEN005300"
RuleID="SV-35172r1_rule"
STIGID="GEN005300"
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
 if grep -i community /etc/SnmpAgent.d/snmpd.conf | grep -v "^#" >> $Results; then
  echo "Manual Review of Community strings and passwords is required" >> $Results
  echo "Fail" >> $Results
 else
  echo "No Community strings or passwords found" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/etc/SnmpAgent.d/snmpd.conf does not exist" >> $Results
 echo "Pass" >> $Results
fi