#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The Internet service daemon configuration files must be protected as malicious modification could cause Denial of Service or increase the attack surface of the system.

#STIG Identification
GrpID="V-22424"
GrpTitle="GEN003745"
RuleID="SV-35073r1_rule"
STIGID="GEN003745"
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
files="$(find /etc -type f \( -name inetd.conf -o -name xinetd.conf \) 2>/dev/null)"
scorecheck=0

if [ -n "$files" ]; then
 for file in $files; do
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   ((scorecheck+=1))
  else
   ls -lLd $file >> $Results
  fi
 done
else
 echo "Files do not exist" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi