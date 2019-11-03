#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the owner of the at directory is not root, bin, or sys, unauthorized users could be allowed to view or edit files containing sensitive information within the directory.

#STIG Identification
GrpID="V-4365"
GrpTitle="GEN003420"
RuleID="SV-38434r1_rule"
STIGID="GEN003420"
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
files="/var/spool/cron/atjobs /var/spool/atjobs /var/spool/at"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
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