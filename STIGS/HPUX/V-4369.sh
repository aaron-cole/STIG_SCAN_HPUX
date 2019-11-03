#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the traceroute command owner has not been set to root, an unauthorized user could use this command to obtain knowledge of the network topology inside the firewall. This information may allow an attacker to determine trusted routers and other network information possibly leading to system and network compromise.

#STIG Identification
GrpID="V-4369"
GrpTitle="GEN003960"
RuleID="SV-35151r1_rule"
STIGID="GEN003960"
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
file="/usr/contrib/bin/traceroute"

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