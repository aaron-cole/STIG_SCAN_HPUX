#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the smbpasswd file is not group-owned by root, it may be maliciously accessed or modified, potentially resulting in the compromise of Samba accounts.

#STIG Identification
GrpID="V-1058"
GrpTitle="GEN006180"
RuleID="SV-37880r1_rule"
STIGID="GEN006180"
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
file="/var/opt/samba/private/smbpasswd"

if [ -e $file ]; then
 GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
 echo "GID for $file is $GOwnerID" >> $Results
 case "$GOwnerID" in
	0|root) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi