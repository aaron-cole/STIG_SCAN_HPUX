#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user can write to the audit logs, audit trails can be modified or destroyed and system intrusion may not be detected.  System audit logs are those files generated from the audit system and do not include activity, error, or other log files created by application software.

#STIG Identification
GrpID="V-813"
GrpTitle="GEN002700"
RuleID="SV-38478r2_rule"
STIGID="GEN002700"
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
filecheckmode="640"
dircheckmode="750"

for file in $files; do
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  if [ $filemode -le $filecheckmode ]; then
   echo "PASS - $(ls -l $file)" >> $Results
  else
   echo "FAIL - $(ls -l $file)" >> $Results
  ((scorecheck+=1))
  fi
  delimitercount="$(echo "$file" | tr "/" "\n" | grep -v "^$" | wc -l)"
  filedir="$(echo "$file" | cut -f "1-$delimitercount" -d "/")"
  filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $filedir)"
  if [ $filedirmode -le $dircheckmode ]; then
   echo "PASS - $(ls -ld $filedir)" >> $Results
  else
   echo "FAIL - $(ls -ld $filedir)" >> $Results
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