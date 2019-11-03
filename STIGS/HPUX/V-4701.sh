#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The finger service provides information about the system's users to network clients. This could expose information that could be used in subsequent attacks.

#STIG Identification
GrpID="V-4701"
GrpTitle="GEN003860"
RuleID="SV-35136r1_rule"
STIGID="GEN003860"
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

grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -i "fingerd" >> $Results

if [ "$(grep -v "^#" /etc/inetd.conf | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | grep -c -i "fingerd")" != 0 ]; then
 echo "fingerd service is enabled" >> $Results 
 echo "Fail" >> $Results 
else
 echo "fingerd service is not found" >> $Results 
 echo "Pass" >> $Results
fi