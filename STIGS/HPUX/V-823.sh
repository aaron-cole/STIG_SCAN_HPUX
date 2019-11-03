#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of sensitive files or utilities to root or bin provides the designated owner and unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-823"
GrpTitle="GEN003760"
RuleID="SV-35077r1_rule"
STIGID="GEN003760"
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
file="/etc/services"

if [ -e $file ]; then
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	0|2|root|bin) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi