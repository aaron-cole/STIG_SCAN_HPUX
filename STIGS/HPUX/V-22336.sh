#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/group file is critical to system security and must be protected from unauthorized modification.  The group file contains a list of system groups and associated information.

#STIG Identification
GrpID="V-22336"
GrpTitle="GEN001392"
RuleID="SV-38338r1_rule"
STIGID="GEN001392"
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
file="/etc/group"

if [ -e $file ]; then
 GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
 echo "GID for $file is $GOwnerID" >> $Results
 case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Fail" >> $Results
fi