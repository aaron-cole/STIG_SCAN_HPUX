#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To protect the integrity of scheduled system jobs and to prevent malicious modification to these jobs, crontab files must be secured.

#STIG Identification
GrpID="V-979"
GrpTitle="GEN003100"
RuleID="SV-38546r1_rule"
STIGID="GEN003100"
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
file="/var/spool/cron/crontabs"

if [ -e $file ]; then
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="750"
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