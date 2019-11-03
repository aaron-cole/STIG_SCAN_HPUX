#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to make root the owner of sensitive files and utilities may provide unauthorized owners the potential to access and/or change sensitive information or system configurations, thus weakening the overall security posture of a site.

#STIG Identification
GrpID="V-966"
GrpTitle="GEN000000-HPUX0060"
RuleID="SV-38682r1_rule"
STIGID="GEN000000-HPUX0060"
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
file="/etc/securetty"

if [ -e $file ]; then
 OwnerID="$(perl -le'print((stat shift)[4])' $file)"
 echo "UID for $file is $OwnerID" >> $Results
 case "$OwnerID" in
	0|2|3|root|bin|sys) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
 esac
else
 echo "$file does not exist" >> $Results
 echo "Pass" >> $Results
fi