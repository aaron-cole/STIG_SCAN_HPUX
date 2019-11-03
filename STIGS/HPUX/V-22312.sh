#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Files without a valid group owner may be unintentionally inherited if a group is assigned the same GID as the GID of the files without a valid group owner.

#STIG Identification
GrpID="V-22312"
GrpTitle="GEN001170"
RuleID="SV-38279r1_rule"
STIGID="GEN001170"
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

checkfiles="$(find / -nogroup 2>>/dev/null)"

if [ -z "$checkfiles" ]; then
 echo "All files have a valid group" >> $Results
 echo "Pass" >> $Results
else
 echo "Files found without a valid group" >> $Results
 echo "$checkfiles" >> $Results
 echo "Fail" >> $Results
fi