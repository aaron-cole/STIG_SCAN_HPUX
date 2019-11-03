#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/group file is critical to system security and must be owned by a privileged user.  The group file contains a list of system groups and associated information.

#STIG Identification
GrpID="V-22335"
GrpTitle="GEN001391"
RuleID="SV-38337r1_rule"
STIGID="GEN001391"
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
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	2|bin) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Fail" >> $Results
fi