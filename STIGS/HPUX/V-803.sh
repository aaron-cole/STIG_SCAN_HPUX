#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Files with the setuid bit set will allow anyone running these files to be temporarily assigned the UID of the file. While many system files depend on these attributes for proper operation, security problems can result if setuid is assigned to programs that allow reading and writing of files, or shell escapes.

#STIG Identification
GrpID="V-803"
GrpTitle="GEN002400"
RuleID="SV-38472r1_rule"
STIGID="GEN002400"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###

if ps -ef | grep -i tripwire | grep -v grep >> $Results; then
 echo "Tripwire installed and Running" >> $Results
 echo "Pass" >> $Results
else
 echo "Tripwire is not installed and running" >> $Results
 echo "What other file integrity tool is used?" >> $Results
 echo "Fail" >> $Results 
fi