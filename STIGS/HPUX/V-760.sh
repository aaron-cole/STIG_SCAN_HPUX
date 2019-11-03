#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Shared accounts (accounts where two or more people log in with the same user identification) do not provide identification and authentication.  There is no way to provide for non-repudiation or individual accountability.

#STIG Identification
GrpID="V-760"
GrpTitle="GEN000280"
RuleID="SV-38441r1_rule"
STIGID="GEN000280"
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
#Maybe ask question????
last | tail -n 20 >> $Results
  echo "Manual" >> $Results