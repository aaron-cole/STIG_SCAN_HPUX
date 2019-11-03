#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the alias file is not group-owned by root, bin, sys or other, an unauthorized user may modify the file to add aliases to run malicious code or redirect e-mail.

#STIG Identification
GrpID="V-22438"
GrpTitle="GEN004370"
RuleID="SV-35163r1_rule"
STIGID="GEN004370"
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
file="/etc/mail/aliases"

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