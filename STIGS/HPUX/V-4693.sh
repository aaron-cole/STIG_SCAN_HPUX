#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The VRFY (Verify) command allows an attacker to determine if an account exists on a system, providing significant assistance to a brute force attack on user accounts. VRFY may provide additional information about users on the system, such as the full names of account owners.

#STIG Identification
GrpID="V-4693"
GrpTitle="GEN004680"
RuleID="SV-35083r1_rule"
STIGID="GEN004680"
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

OUTPUT="$({ echo "vrfy root"; echo "quit"; } | telnet localhost 25 2>>/dev/null)"

if echo "$OUTPUT" | grep "5[0-9][0-9]" >> $Results; then
 echo "Telnet command verified" >> $Results
 echo "Pass" >> $Results
elif grep "^O PrivacyOptions=" /etc/mail/sendmail.cf | egrep "goaway|novrfy" >> $Results; then
 echo "Setting set in /etc/mail/sendmail.cf" >> $Results
 echo "Pass" >> $Results
else
 echo "$OUTPUT" >> $Results
 grep "^O PrivacyOptions=" /etc/mail/sendmail.cf >> $Results
 echo "Fail" >> $Results
fi