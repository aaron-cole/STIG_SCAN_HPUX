#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The SMTP EXPN function allows an attacker to determine if an account exists on a system, providing significant assistance to a brute force attack on user accounts. EXPN may also provide additional information concerning users on the system, such as the full names of account owners.

#STIG Identification
GrpID="V-4692"
GrpTitle="GEN004660"
RuleID="SV-35076r1_rule"
STIGID="GEN004660"
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

OUTPUT="$({ echo "expn root"; echo "quit"; } | telnet localhost 25 2>>$Results)"

if echo "$OUTPUT" | grep -v 'Trying...' | grep "5[0-9][0-9]" >> $Results; then
 echo "Pass" >> $Results
elif grep "telnet: Unable to connect to remote host: Connection refused" $Results >> /dev/null; then
 echo "Sendmail is not accepting inbound connections" >> $Results
 echo "Pass" >> $Results
else
 echo "$OUTPUT" >> $Results
 echo "Fail" >> $Results
fi