#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the startup files are writable by other users, they could modify the startup files to insert malicious commands into the startup files.

#STIG Identification
GrpID="V-906"
GrpTitle="GEN001580"
RuleID="SV-38494r1_rule"
STIGID="GEN001580"
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
files="/sbin/init.d/[a-z,A-Z,0-9]*"
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