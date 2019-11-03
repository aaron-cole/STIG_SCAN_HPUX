#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the ftpusers file is not group-owned by root or a system group, an unauthorized user may modify the file to allow unauthorized accounts to use FTP.

#STIG Identification
GrpID="V-22444"
GrpTitle="GEN004930"
RuleID="SV-35104r1_rule"
STIGID="GEN004930"
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
file="/etc/ftpd/ftpusers"

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