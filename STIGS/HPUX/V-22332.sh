#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/passwd file contains the list of local system accounts.  It is vital to system security and must be protected from unauthorized modification.

#STIG Identification
GrpID="V-22332"
GrpTitle="GEN001378"
RuleID="SV-38335r1_rule"
STIGID="GEN001378"
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
file="/etc/passwd"

if [ -e $file ]; then
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	0|root) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Fail" >> $Results
fi