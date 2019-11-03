#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The nodev (or equivalent) mount option causes the system to not handle device files as system devices. This option must be used for mounting any file system not containing approved device files. Device files can provide direct access to system hardware and can compromise security if not protected.

#STIG Identification
GrpID="V-22368"
GrpTitle="GEN002430"
RuleID="SV-29568r1_rule"
STIGID="GEN002430"
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

if grep -v "^#" /etc/fstab | grep "nfs" >> $Results; then
 if grep -v "^#" /etc/fstab | grep "nfs" | grep "nodevs" >> /dev/null; then
  echo "nodevs option applied to NFS mounts" >> $Results
  echo "Pass" >> $Results
 else
  echo "NFS mount found and nodevs option not being used" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "No NFS mounts found in /etc/fstab" >> $Results
 echo "Pass" >> $Results
fi