#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Virus scanning software can be used to protect a system from penetration from computer viruses and to limit their spread through intermediate systems.

#STIG Identification
GrpID="V-81451"
GrpTitle="GEN006650"
RuleID="SV-96165r1_rule"
STIGID="GEN006650"
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

if [ -f /usr/local/uvscan/uvscan ]; then
 /usr/local/uvscan/uvscan --VERSION >> $Results
 echo "Pass" >> $Results
else
 echo "Does the system have antivirus installed on it?" >> $Results
 echo "Fail" >> $Results
fi
