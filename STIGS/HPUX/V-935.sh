#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the NFS server allows root access to local file systems from remote hosts, this access could be used to compromise the system.

#STIG Identification
GrpID="V-935"
GrpTitle="GEN005880"
RuleID="SV-35202r1_rule"
STIGID="GEN005880"
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

if [ -e /etc/dfs/sharetab ]; then
 if grep "root=" /etc/dfs/sharetab >> $Results; then
  echo "Fail" >> $Results 
 else 
  echo "No root options found in /etc/dfs/sharetab" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "/etc/dfs/sharetab does not exist" >> $Results
 echo "Pass" >> $Results
fi