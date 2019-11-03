#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Cron daemon control files restrict the scheduling of automated tasks and must be protected.

#STIG Identification
GrpID="V-4430"
GrpTitle="GEN003260"
RuleID="SV-38439r1_rule"
STIGID="GEN003260"
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
file="/var/adm/cron/cron.deny"

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