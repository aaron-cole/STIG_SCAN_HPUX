#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The snmpd.conf file contains authenticators and must be protected from unauthorized access and modification. If the file is not group-owned by root or a system group, it may be subject to access and modification from unauthorized users.

#STIG Identification
GrpID="V-22451"
GrpTitle="GEN005365"
RuleID="SV-26734r1_rule"
STIGID="GEN005365"
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