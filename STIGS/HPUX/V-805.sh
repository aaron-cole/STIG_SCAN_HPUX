#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The "nosuid" mount option causes the system to not execute setuid files with owner privileges. This option must be used for mounting any file system not containing approved setuid files. Executing setuid files from untrusted file systems, or file systems that do not contain approved setuid files, increases the opportunity for unprivileged users to attain unauthorized administrative access.

#STIG Identification
GrpID="V-805"
GrpTitle="GEN002420"
RuleID="SV-34946r1_rule"
STIGID="GEN002420"
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

echo "Ensure the nosuid is set on file systems that are not documented with the ISSM" >> $Results
echo "Fail" >> $Results