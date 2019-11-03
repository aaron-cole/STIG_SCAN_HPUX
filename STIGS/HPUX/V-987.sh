#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Permissions more permissive than 0600 (i.e. read, write and execute for the owner) may allow unauthorized or malicious access to the at.allow and/or at.deny files.

#STIG Identification
GrpID="V-987"
GrpTitle="GEN003340"
RuleID="SV-38553r1_rule"
STIGID="GEN003340"
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
file="/var/adm/cron/at.allow"

if [ -e $file ]; then
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="600"
 if [ $filemode -le $checkmode ]; then
  echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  echo "Pass" >> $Results
 else
  echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi