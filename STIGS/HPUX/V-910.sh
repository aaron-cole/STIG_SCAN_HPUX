#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#World-writable files could be modified accidentally or maliciously to compromise system integrity.

#STIG Identification
GrpID="V-910"
GrpTitle="GEN001640"
RuleID="SV-38496r2_rule"
STIGID="GEN001640"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
