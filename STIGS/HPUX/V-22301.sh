#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22301"
GrpTitle="GEN000510"
RuleID="SV-38275r1_rule"
STIGID="GEN000510"
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

if who -r | grep "run-level 3" >> $Results; then
 echo "Graphic Display is not running" >> $Results
 echo "Pass" >> $Results
else
 echo "Manual Check" >> $Results
 echo "Fail" >> $Results
fi