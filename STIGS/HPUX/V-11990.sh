#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-11990"
GrpTitle="GEN002540"
RuleID="SV-38265r1_rule"
STIGID="GEN002540"
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
#File or Directory to check
files="$(find / -type d -perm -1002 2>/dev/null)"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  
  case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "PASS - GID for $file is $GOwnerID" >> $Results;;
	*) echo "FAIL - GID for $file is $GOwnerID" >> $Results
	   ((scorecheck+=1));;
  esac
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