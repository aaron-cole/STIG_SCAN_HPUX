#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The nsswitch.conf file (or equivalent) configures the source of a variety of system security information including account, group, and host lookups.  Malicious changes could prevent the system from functioning or compromise system security.

#STIG Identification
GrpID="V-22328"
GrpTitle="GEN001372"
RuleID="SV-38317r1_rule"
STIGID="GEN001372"
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
file="/etc/nsswitch.conf"

if [ -e $file ]; then
 GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
 echo "GID for $file is $GOwnerID" >> $Results
 case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "Pass"  >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Fail" >> $Results
fi