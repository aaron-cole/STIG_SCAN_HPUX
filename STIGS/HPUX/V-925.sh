#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#System backups could be accidentally or maliciously overwritten and destroy the ability to recover the system if a compromise should occur.  Unauthorized users could also copy system files.

#STIG Identification
GrpID="V-925"
GrpTitle="GEN002300"
RuleID="SV-38506r1_rule"
STIGID="GEN002300"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
