#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Without a host-based intrusion detection tool, there is no system-level defense when an intruder gains access to a system or network.  Additionally, a host-based intrusion detection tool can provide methods to immediately lock out detected intrusion attempts.

#STIG Identification
GrpID="V-782"
GrpTitle="GEN006480"
RuleID="SV-35141r1_rule"
STIGID="GEN006480"
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

if swlist | grep IDS >> $Results; then
 if ps -ef | grep idsagent >> $Results; then
  echo "HPUX HIDS is installed and Running" >> $Results
  echo "Pass" >> $Results 
 else
  echo "HPUX HIDS is installed but not Running" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "HPUX IDS not installed. Is there another IDS installed" >> $Results
 echo "Fail" >> $Results
fi