#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the file ftpusers is not owned by root, an unauthorized user may modify the file to allow unauthorized accounts to use FTP.

#STIG Identification
GrpID="V-842"
GrpTitle="GEN004920"
RuleID="SV-38485r1_rule"
STIGID="GEN004920"
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
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	0|root) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi