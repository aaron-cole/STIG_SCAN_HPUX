#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Enabling the nosuid mount option prevents the system from granting owner or group-owner privileges to programs with the suid or sgid bit set.  If the system does not restrict this access, users with unprivileged access to the local system may be able to acquire privileged access by executing suid or sgid files located on the mounted NFS file system.

#STIG Identification
GrpID="V-936"
GrpTitle="GEN005900"
RuleID="SV-35204r1_rule"
STIGID="GEN005900"
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

if mount -v | grep "type nfs" | grep -v "nosuid" >> $Results; then
  echo "Fail" >> $Results
else  
 if grep "nfs" /etc/fstab | grep -v "nosuid" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "No NFS mounts found" >> $Results
  echo "Pass" >> $Results
 fi
fi