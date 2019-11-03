#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the skeleton files are not protected, unauthorized personnel could change user startup parameters and possibly jeopardize user files.

#STIG Identification
GrpID="V-22357"
GrpTitle="GEN001810"
RuleID="SV-38346r1_rule"
STIGID="GEN001810"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
files="/etc/skel/.* /etc/skel/*"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
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