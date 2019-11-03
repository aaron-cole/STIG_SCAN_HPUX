#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Cron daemon control files restrict the scheduling of automated tasks and must be protected. Unauthorized modification of the cron.deny file could result in Denial of Service to authorized cron users or could provide unauthorized users with the ability to run cron jobs.

#STIG Identification
GrpID="V-22394"
GrpTitle="GEN003270"
RuleID="SV-34993r1_rule"
STIGID="GEN003270"
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
 GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
 echo "GID for $file is $GOwnerID" >> $Results
 case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi