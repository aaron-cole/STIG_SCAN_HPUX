#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system journaling, or logging, can allow reconstruction of file system data after a system crash, thus preserving the integrity of data that may have otherwise been lost. Journaling file systems typically do not require consistency checks upon booting after a crash, which can improve system availability. Some file systems employ other mechanisms to ensure consistency which also satisfy this requirement.

#STIG Identification
GrpID="V-22422"
GrpTitle="GEN003650"
RuleID="SV-26639r1_rule"
STIGID="GEN003650"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Checks

if grep "hfs" /etc/fstab | grep -v "^#" | grep -v "/stand" >> $Results; then 
 echo "Fail" >> $Results
else
 echo "No HFS filesystems were found" >> $Results
 echo "Pass" >> $Results
fi