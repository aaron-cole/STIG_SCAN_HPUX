#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give group ownership of the NFS share configuration file to root, bin, sys or other provides the designated group owner and possible unauthorized users with the potential to change system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-22492"
GrpTitle="GEN005750"
RuleID="SV-35183r1_rule"
STIGID="GEN005750"
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
file="/etc/dfs/dfstab"

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