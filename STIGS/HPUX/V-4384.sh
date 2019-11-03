#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The version of the SMTP service can be used by attackers to plan an attack based on vulnerabilities present in the specific version.

#STIG Identification
GrpID="V-4384"
GrpTitle="GEN004560"
RuleID="SV-38436r1_rule"
STIGID="GEN004560"
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

if [ -e /etc/mail/sendmail.cf ]; then
 if grep "^O SmtpGreetingMessage= " /etc/mail/sendmail.cf | grep '$v' >> $Results; then
  echo "Sendmail will display version information" >> $Results
  echo "Fail" >> $Results
 else
  grep "^O SmtpGreetingMessage= " /etc/mail/sendmail.cf >> $Results
  echo "Version information is turned off" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "sendmail configuration file not found" >> $Results
 echo "Pass" >> $Results
fi