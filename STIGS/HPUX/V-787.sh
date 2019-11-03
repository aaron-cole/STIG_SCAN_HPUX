#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the system log files are not protected, unauthorized users could change the logged data, eliminating its forensic value.

#STIG Identification
GrpID="V-787"
GrpTitle="GEN001260"
RuleID="SV-35275r1_rule"
STIGID="GEN001260"
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
files="$(find /var/log /var/log/syslog /var/adm /var/opt -type f \( -perm -100 -o -perm -020 -o -perm -001 -o -perm -002 -o -perm -004 \) \
! -path "/var/adm/sw/*" ! -path "/var/opt/*provider/*" -name "*log" ! -name "*install*" 2>>/dev/null)"

if [ -z "$files" ]; then
 echo "Nothing found" >> $Results
else
 echo "Review files to see if they are system logs files" >> $Results
 for file in $files; do
  ls -l "$file" >> $Results
 done
 echo "Fail" >> $Results
fi
