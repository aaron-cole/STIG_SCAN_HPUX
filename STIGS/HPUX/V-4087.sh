#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If start-up files execute world-writable programs, especially in unprotected directories, they could be maliciously modified to become Trojans destroying user files or otherwise compromise the system at the user level or higher. If the system is compromised at the user level, it is much easier to eventually compromise the system at the root and network level.

#STIG Identification
GrpID="V-4087"
GrpTitle="GEN001940"
RuleID="SV-38418r1_rule"
STIGID="GEN001940"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##
