#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If shell files are group-owned by users other than root or a system group, they could be modified by intruders or malicious users to perform unauthorized actions.

#STIG Identification
GrpID="V-22365"
GrpTitle="GEN002210"
RuleID="SV-38352r1_rule"
STIGID="GEN002210"
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
files="$(cat /etc/shells)"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  echo "GID for $file is $GOwnerID" >> $Results
  case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
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