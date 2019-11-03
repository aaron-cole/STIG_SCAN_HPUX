#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#All files with the setgid bit set will allow anyone running these files to be temporarily assigned the GID of the file. While many system files depend on these attributes for proper operation, security problems can result if setgid is assigned to programs that allow reading and writing of files, or shell escapes.

#STIG Identification
GrpID="V-802"
GrpTitle="GEN002440"
RuleID="SV-34943r1_rule"
STIGID="GEN002440"
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

echo "SetGID Files" >> $Results
echo "Are they Documented with the ISSM? If so this can be closed" >> $Results
find / -perm -2000 -exec ls -lLd {} \; >> $Results
echo "Fail" >> $Results