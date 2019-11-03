#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification. If the file is not owned by bin, it may be subject to access and modification from unauthorized users.

#STIG Identification
GrpID="V-12019"
GrpTitle="GEN005360"
RuleID="SV-35203r1_rule"
STIGID="GEN005360"
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
file="/etc/SnmpAgent.d/snmpd.conf"

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