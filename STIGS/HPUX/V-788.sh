#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-788"
GrpTitle="GEN001800"
RuleID="SV-38459r1_rule"
STIGID="GEN001800"
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
files="/etc/skel/.*"
scorecheck=0

for file in $files; do
 if [ "$file" = "/etc/skel/." ] || [ "$file" = "/etc/skel/.." ]; then
 continue
 fi
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="444"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   ((scorecheck+=1))
  fi
 else
  echo "$file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi