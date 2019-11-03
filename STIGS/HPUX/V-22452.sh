#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification.

#STIG Identification
GrpID="V-22452"
GrpTitle="GEN005375"
RuleID="SV-26738r1_rule"
STIGID="GEN005375"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
file="/etc/SnmpAgent.d/snmpd.conf"
ls -lLd $file >> $Results

if [ -e $file ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Pass" >> $Results
fi