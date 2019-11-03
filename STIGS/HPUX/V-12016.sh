#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If access to the X server is not restricted, the user's X session may be compromised.

#STIG Identification
GrpID="V-12016"
GrpTitle="GEN005220"
RuleID="SV-38287r1_rule"
STIGID="GEN005220"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
