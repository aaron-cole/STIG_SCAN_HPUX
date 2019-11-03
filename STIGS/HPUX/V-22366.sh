#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Shells with world/group write permissions give the ability to maliciously modify the shell to obtain unauthorized access.

#STIG Identification
GrpID="V-22366"
GrpTitle="GEN002230"
RuleID="SV-38353r1_rule"
STIGID="GEN002230"
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
files="$(cat /etc/shells)"
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