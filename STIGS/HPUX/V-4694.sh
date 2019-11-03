#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Very old installations of the Sendmail mailing system contained a feature whereby a remote user connecting to the SMTP port can enter the WIZ command and be given an interactive shell with root privileges.

#STIG Identification
GrpID="V-4694"
GrpTitle="GEN004700"
RuleID="SV-35093r1_rule"
STIGID="GEN004700"
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

if grep -i "wiz" /etc/mail/sendmail.cf | grep -v "^#" >> $Results; then
 echo "Fail" >> $Results
else
 echo "wiz Setting Not Found in /etc/mail/sendmail.cf" >> $Results
 echo "Pass" >> $Results
fi