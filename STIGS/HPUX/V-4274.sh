#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions on the hosts.nntp.nolimit file may allow unauthorized modification which could lead to Denial of Service to authorized users or provide access to unauthorized users.

#STIG Identification
GrpID="V-4274"
GrpTitle="GEN006280"
RuleID="SV-35116r1_rule"
STIGID="GEN006280"
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
#file="$(find / -type f -name hosts.nntp.nolimit 2>/dev/null)"

if [ -f /etc/news/hosts.nntp.nolimit ]; then
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
 echo "hosts.nntp.nolimit does not exist" >> $Results
 echo "Pass" >> $Results
fi