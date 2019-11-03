#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File permissions more permissive than 0600 for /etc/news/passwd.nntp may allow access to privileged information by system intruders or malicious users.

#STIG Identification
GrpID="V-4276"
GrpTitle="GEN006320"
RuleID="SV-35120r1_rule"
STIGID="GEN006320"
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
#file="$(find / -type f -name passwd.nntp 2>/dev/null)"

if [ -f /etc/news/passwd.nntp ]; then
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
 echo "passwd.nntp does not exist" >> $Results
 echo "Pass" >> $Results
fi