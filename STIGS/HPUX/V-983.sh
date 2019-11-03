#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Cron logs contain reports of scheduled system activities and must be protected from unauthorized access or manipulation.

#STIG Identification
GrpID="V-983"
GrpTitle="GEN003180"
RuleID="SV-38550r1_rule"
STIGID="GEN003180"
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
file="/var/adm/cron/log"

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