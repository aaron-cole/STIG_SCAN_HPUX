#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the owner of the at.deny file is not set to root, bin, or sys, unauthorized users could be allowed to view or edit sensitive information contained within the file.

#STIG Identification
GrpID="V-4368"
GrpTitle="GEN003480"
RuleID="SV-34998r1_rule"
STIGID="GEN003480"
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
file="/var/adm/cron/at.deny"

if [ -e $file ]; then
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	0|2|3|root|bin|sys) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi