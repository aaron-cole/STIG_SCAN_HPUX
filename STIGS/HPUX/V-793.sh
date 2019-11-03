#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unauthorized access could destroy the integrity of the library files.

#STIG Identification
GrpID="V-793"
GrpTitle="GEN001300"
RuleID="SV-38464r1_rule"
STIGID="GEN001300"
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
files="$(find /usr/lib /lib -type f \( -name "*.a" -o -name "*.so*" \) \( -perm -020 -o -perm -002 \) 2>>/dev/null)"

if [ -n "$files" ]; then
 echo "Files found with more permissive than 755" >> $Results
 echo "$files" >> $Results
 echo "Fail" >> $Results
else
 echo "Library Files are not more permissive than 755" >> $Results
 echo "Pass" >> $Results
fi


