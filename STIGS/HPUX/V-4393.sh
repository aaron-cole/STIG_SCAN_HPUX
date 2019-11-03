#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the /etc/syslog.conf file is not owned by bin, unauthorized users could be allowed to view, edit, or delete important system messages handled by the syslog facility.

#STIG Identification
GrpID="V-4393"
GrpTitle="GEN005400"
RuleID="SV-38437r1_rule"
STIGID="GEN005400"
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
file="/etc/syslog.conf"

if [ -e $file ]; then
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	2|bin) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi