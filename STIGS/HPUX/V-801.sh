#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#All files with the setuid bit set will allow anyone running these files to be temporarily assigned the UID of the file. While many system files depend on these attributes for proper operation, security problems can result if setuid is assigned to programs that allow reading and writing of files, or shell escapes.  Only default vendor-supplied executables should have the setuid bit set.

#STIG Identification
GrpID="V-801"
GrpTitle="GEN002380"
RuleID="SV-38471r1_rule"
STIGID="GEN002380"
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

echo "SetUID Files" >> $Results
echo "Are they Documented with the ISSM? If so this can be closed" >> $Results
find / -perm -4000 -exec ls -lL {} \; >> $Results
echo "Fail" >> $Results