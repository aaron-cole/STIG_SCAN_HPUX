#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A local firewall protects the system from exposing unnecessary or undocumented network services to the local enclave.  If a system within the enclave is compromised, firewall protection on an individual system continues to protect it from attack.

#STIG Identification
GrpID="V-22583"
GrpTitle="GEN008540"
RuleID="SV-26977r1_rule"
STIGID="GEN008540"
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
ipfstat -i 2>>/dev.null | grep "block in" | grep "any to any" >> $Results

if [ "$(ipfstat -i 2>>/dev.null | grep "block in" | grep "any to any$" | wc -l)" -ge 1 ]; then
 echo "IPF is configured with default deny rule" >> $Results
 echo "Pass" >> $Results 
else
 echo "IPF is NOT configured with default deny rule" >> $Results
 echo "Fail" >> $Results
fi