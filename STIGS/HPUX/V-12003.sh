#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The use of separate file systems for different paths can protect the system from failures resulting from the / file system becoming full or failing.

#STIG Identification
GrpID="V-12003"
GrpTitle="GEN003620"
RuleID="SV-35048r1_rule"
STIGID="GEN003620"
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

if grep " /home " /etc/fstab >> $Results; then 
 echo "/home is on it's own filesystem" >> $Results
 echo "Pass" >> $Results
else
 echo "/home is NOT on it's own filesystem" >> $Results
 echo "Fail" >> $Results
fi