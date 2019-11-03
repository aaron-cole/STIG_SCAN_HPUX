#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user can write to the audit logs, then audit trails can be modified or destroyed and system intrusion may not be detected.

#STIG Identification
GrpID="V-22369"
GrpTitle="GEN002710"
RuleID="SV-38355r2_rule"
STIGID="GEN002710"
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
files="$(egrep "PRI_AUDFILE|SEC_AUDFILE" /etc/rc.config.d/auditing | grep -v "^#" | cut -f 2 -d "=")"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   echo "FAIL - $(ls -ld $file)" >> $Results
   ((scorecheck+=1))
  else
   echo "PASS - $(ls -ld $file)" >> $Results
  fi
  delimitercount="$(echo "$file" | tr "/" "\n" | grep -v "^$" | wc -l)"
  filedir="$(echo "$file" | cut -f "1-$delimitercount" -d "/")"
  if ls -lLd $filedir | awk '{print $1}' | grep "+" >> $Results; then
   echo "FAIL - $(ls -ld $filedir)" >> $Results
   ((scorecheck+=1))
  else
   echo "PASS - $(ls -ld $filedir)" >> $Results
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