#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the group-owner of the at.allow file is not set to root, sys, bin or other, unauthorized users could be allowed to view or edit the list of users permitted to run at jobs. Unauthorized modification could result in Denial of Service to authorized at users or provide unauthorized users with the ability to run at jobs.

#STIG Identification
GrpID="V-22397"
GrpTitle="GEN003470"
RuleID="SV-26571r1_rule"
STIGID="GEN003470"
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
file="/usr/lib/cron/at.allow"

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