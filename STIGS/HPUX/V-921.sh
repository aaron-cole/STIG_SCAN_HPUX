#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If shell files are owned by users other than root or bin, they could be modified by intruders or malicious users to perform unauthorized actions.

#STIG Identification
GrpID="V-921"
GrpTitle="GEN002200"
RuleID="SV-38501r1_rule"
STIGID="GEN002200"
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
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|2|root|bin) echo "" >> /dev/null;;
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