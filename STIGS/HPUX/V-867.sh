#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Due to numerous security vulnerabilities existing within NIS, it must not be used. Possible alternative directory services are NIS+ and LDAP.

#STIG Identification
GrpID="V-867"
GrpTitle="GEN006400"
RuleID="SV-38487r1_rule"
STIGID="GEN006400"
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

if ps -ef | egrep "ypbind|ypserv" | grep -v "grep" >> $Results; then
 echo "Fail" >> $Results
else 
 echo "NIS not active on the system" >> $Results
 echo "Pass" >> $Results
fi