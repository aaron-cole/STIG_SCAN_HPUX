#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A common configuration for older mail transfer agents (MTAs) is to include an alias for the decode user.  All mail sent to this user is sent to the uudecode program, which automatically converts and stores files.  By sending mail to the decode or the uudecode aliases present on some systems, a remote attacker may be able to create or overwrite files on the remote host.  This could possibly be used to gain remote access.

#STIG Identification
GrpID="V-4691"
GrpTitle="GEN004640"
RuleID="SV-35071r1_rule"
STIGID="GEN004640"
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

OUTPUT="$({ echo "decode"; echo "quit"; } | telnet localhost 25 2>>$Results)"

if echo "$OUTPUT" | grep -v 'Trying...' | grep "5[0-9][0-9]" >> $Results; then
 echo "Pass" >> $Results
elif grep "telnet: Unable to connect to remote host: Connection refused" $Results >> /dev/null; then
 echo "Sendmail is not accepting inbound connections" >> $Results
 echo "Pass" >> $Results
else
 echo "$OUTPUT" >> $Results
 echo "Fail" >> $Results
fi