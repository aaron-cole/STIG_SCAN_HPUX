#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Restricting permission on daemons will protect them from unauthorized modification and possible system compromise.

#STIG Identification
GrpID="V-22313"
GrpTitle="GEN001190"
RuleID="SV-38280r1_rule"
STIGID="GEN001190"
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

grep -v '^#' /etc/inetd.conf | sed -e 's/^[ \t]*//' | tr '\011' ' ' | tr -s ' ' | cut -f6,6 -d " " | xargs -n1 ls -lL >> $Results

if [ "$(grep -v '^#' /etc/inetd.conf | sed -e 's/^[ \t]*//' | tr '\011' ' ' | tr -s ' ' | cut -f6,6 -d " " | xargs -n1 ls -lL | grep -c "+")" != 0 ]; then
 echo "Network service daemon files have ACLs" >> $Results 
 echo "Fail" >> $Results 
else
 echo "Network service daemon files DO NOT have ACLs" >> $Results 
 echo "Pass" >> $Results
fi