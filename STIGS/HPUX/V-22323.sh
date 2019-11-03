#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/hosts file (or equivalent) configures local host name to IP address mappings that typically take precedence over DNS resolution.  If this file is maliciously modified, it could cause the failure or compromise of security functions requiring name resolution, which may include time synchronization, centralized authentication, and remote system logging.

#STIG Identification
GrpID="V-22323"
GrpTitle="GEN001366"
RuleID="SV-38313r1_rule"
STIGID="GEN001366"
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
file="/etc/hosts"

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
