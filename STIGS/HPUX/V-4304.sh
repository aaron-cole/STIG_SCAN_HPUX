#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system journaling, or logging, can allow reconstruction of file system data after a system crash, thus, preserving the integrity of data that may have otherwise been lost. Journaling file systems typically do not require consistency checks upon booting after a crash, which can improve system availability. Some file systems employ other mechanisms to ensure consistency which also satisfy this requirement.

#STIG Identification
GrpID="V-4304"
GrpTitle="GEN003640"
RuleID="SV-35057r1_rule"
STIGID="GEN003640"
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

if egrep "jfs|vxfs|hfs|xfs|ext3|ext4|zfs" /etc/fstab | grep "/ " | grep -v "nolog" >> $Results; then 
 echo "Pass" >> $Results
else
 echo "Logging is not turned on for / filesystem" >> $Results
 echo "Fail" >> $Results 
fi