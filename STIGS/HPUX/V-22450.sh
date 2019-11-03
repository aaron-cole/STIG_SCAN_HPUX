#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The ability to read the MIB file could impart special knowledge to an intruder or malicious user about the ability to extract compromising information about the system or network.

#STIG Identification
GrpID="V-22450"
GrpTitle="GEN005350"
RuleID="SV-38374r1_rule"
STIGID="GEN005350"
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
files="$(find / -type f -name *.mib 2>/dev/null)"
scorecheck=0

if [ -n "$files" ]; then
 for file in $files; do
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   ((scorecheck+=1))
  fi
 done
else
 echo "mib files do not exist" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi