#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If system startup files do not have a group owner of root or a system group, the files may be modified by malicious users or intruders.

#STIG Identification
GrpID="V-4090"
GrpTitle="GEN001680"
RuleID="SV-38421r1_rule"
STIGID="GEN001680"
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
files="/sbin/init.d/* /etc/rc.config.d/* /etc/rc.config.d/*"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  case "$GOwnerID" in
	0|2|3|1|root|bin|sys|other) echo "PASS - GID for $file is $GOwnerID" >> $Results;;
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