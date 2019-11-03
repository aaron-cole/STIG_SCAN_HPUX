#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the aliases file is not owned by root, an unauthorized user may modify the file to add aliases to run malicious code or redirect e-mail.

#STIG Identification
GrpID="V-831"
GrpTitle="GEN004360"
RuleID="SV-35161r1_rule"
STIGID="GEN004360"
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