#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-806"
GrpTitle="GEN002500"
RuleID="SV-38474r1_rule"
STIGID="GEN002500"
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
scorecheck=0
files="$(find / -type d -perm -002 ! -perm -1000)"

if [ -n "$files" ]; then
 for file in $files; do
  case "$file" in
   /var/spool/sockets*) continue;;
  esac
  ls -ld "$file" >> $Results
  ((scorecheck+=1))
 done
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi