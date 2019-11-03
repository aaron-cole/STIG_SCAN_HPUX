#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Syslog messages are typically unencrypted and may contain sensitive information and are, therefore, restricted to the enclave.

#STIG Identification
GrpID="V-12020"
GrpTitle="GEN005440"
RuleID="SV-35187r1_rule"
STIGID="GEN005440"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
