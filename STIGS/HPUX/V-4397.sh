#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a system has no default gateway defined, the system is at increased risk of man-in-the-middle, monitoring, and Denial of Service attacks.

#STIG Identification
GrpID="V-4397"
GrpTitle="GEN005560"
RuleID="SV-30080r1_rule"
STIGID="GEN005560"
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

if netstat -r | grep default >> $Results; then
 echo "Default route is defined" >> $Results
 echo "Pass" >> $Results
else
 echo "Default route not defined" >> $Results
 echo "Fail" >> $Results
fi
