#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The shells file (or equivalent) lists approved default shells.  It helps provide layered defense to the security approach by ensuring users cannot change their default shell to an unauthorized, unsecure shell.

#STIG Identification
GrpID="V-916"
GrpTitle="GEN002120"
RuleID="SV-34952r1_rule"
STIGID="GEN002120"
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

fdexists="/etc/shells"

if [ ! -e $fdexists ]; then
 echo "$fdexists does not exist" >> $Results
 echo "Fail" >> $Results
else
 echo "$(ls -l $fdexists)" >> $Results
 echo "Pass" >> $Results
fi