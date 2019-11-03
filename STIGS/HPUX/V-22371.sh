#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To prevent unauthorized access or manipulation of system audit logs, the tools for manipulating those logs must be protected.

#STIG Identification
GrpID="V-22371"
GrpTitle="GEN002716"
RuleID="SV-26509r2_rule"
STIGID="GEN002716"
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
files="/usr/sbin/aud* /usr/sbin/userdb*"
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