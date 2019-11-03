#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the passwd file is writable by a group owner or the world, the risk of passwd file compromise is increased. The passwd file contains the list of accounts on the system and associated information.

#STIG Identification
GrpID="V-798"
GrpTitle="GEN001380"
RuleID="SV-38469r1_rule"
STIGID="GEN001380"
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
file="/etc/passwd"

if [ -e $file ]; then
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="444"
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