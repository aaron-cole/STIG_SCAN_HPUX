#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-23953"
GrpTitle="GEN007960"
RuleID="SV-29540r1_rule"
STIGID="GEN007960"
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

echo "Per HP - HPUX ldd implementation protects against the execution of untrusted files" >> $Results
echo "Check is NA" >> $Results
echo "NA" >> $Results