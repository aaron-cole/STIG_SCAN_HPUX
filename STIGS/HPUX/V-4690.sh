#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Debug mode is a feature present in older versions of Sendmail which, if not disabled, may allow an attacker to gain access to a system through the Sendmail service.

#STIG Identification
GrpID="V-4690"
GrpTitle="GEN004620"
RuleID="SV-35070r1_rule"
STIGID="GEN004620"
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

OUTPUT="$({ echo "debug"; echo "quit"; } | telnet localhost 25 2>>$Results)"

if echo "$OUTPUT" | grep -v 'Trying...' | grep "5[0-9][0-9]" >> $Results; then
 echo "Pass" >> $Results
elif grep "telnet: Unable to connect to remote host: Connection refused" $Results >> /dev/null; then
 echo "Sendmail is not accepting inbound connections" >> $Results
 echo "Pass" >> $Results
else
 echo "$OUTPUT" >> $Results
 echo "Fail" >> $Results
fi