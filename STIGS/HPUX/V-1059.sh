#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the smbpasswd file has a mode more permissive than 0600, it may be maliciously accessed or modified, potentially resulting in the compromise of Samba accounts.

#STIG Identification
GrpID="V-1059"
GrpTitle="GEN006200"
RuleID="SV-37883r1_rule"
STIGID="GEN006200"
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
file="/var/opt/samba/private/smbpasswd"

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