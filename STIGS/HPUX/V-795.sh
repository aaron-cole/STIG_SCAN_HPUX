#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting permissions will protect the files from unauthorized modification.

#STIG Identification
GrpID="V-795"
GrpTitle="GEN001220"
RuleID="SV-38466r1_rule"
STIGID="GEN001220"
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
files="$(find /etc /bin /usr/bin /usr/lbin /sbin /usr/sbin ! \( -user root -o -user bin -o -user sys -o -user lp -o -user uucp -o -user oracle -o -user ids -o -user daemon -o -user cimsrvr \) 2>>/dev/null)"

if [ -z "$files" ]; then
 echo "Files are owned by a system account" >> $Results
 echo "Pass" >> $Results
else
 for file in $files; do
  ls -l "$file" >> $Results
 done
 echo "Fail" >> $Results
fi
