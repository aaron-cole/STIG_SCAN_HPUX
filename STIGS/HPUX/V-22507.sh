#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#ACLs can provide permissions beyond those permitted through the file mode and must be verified by file integrity tools.

#STIG Identification
GrpID="V-22507"
GrpTitle="GEN006570"
RuleID="SV-35185r1_rule"
STIGID="GEN006570"
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