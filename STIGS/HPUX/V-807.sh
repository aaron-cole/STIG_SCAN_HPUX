#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-807"
GrpTitle="GEN002520"
RuleID="SV-34950r1_rule"
STIGID="GEN002520"
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
#File or Directory to check
files="$(find / -type d -perm -1002 ! -user root ! -user bin ! -user sys ! -user oracle 2>>/dev/null)"

if [ -z "$files" ]; then
 echo "No public directories found not owned by a system or application acct" >> $Results
 echo "Pass" >> $Results
else
 echo "Check file list for application and system accounts" >> $Results
 for file in $files; do
  ls -ld $file >> $Results
 done
 echo "Fail" >> $Results
fi