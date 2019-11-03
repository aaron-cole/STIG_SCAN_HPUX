#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Root, sys, and bin are the most privileged group accounts, by default, for most UNIX systems.  If a file as sensitive as /etc/securetty is not group-owned by a privileged group, it could lead to system compromise.

#STIG Identification
GrpID="V-965"
GrpTitle="GEN000000-HPUX0080"
RuleID="SV-965r2_rule"
STIGID="GEN000000-HPUX0080"
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
file="/etc/securetty"

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