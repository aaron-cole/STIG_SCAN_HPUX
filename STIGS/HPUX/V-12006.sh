#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The HELP command should be disabled to mask version information.  The version of the SMTP service software could be used by attackers to target vulnerabilities present in specific software versions.

#STIG Identification
GrpID="V-12006"
GrpTitle="GEN004540"
RuleID="SV-35059r2_rule"
STIGID="GEN004540"
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

if [ ! -f /etc/mail/helpfile ]; then
 echo "/etc/mail/helpfile does not exist" >> $Results
 echo "Pass" >> $Results
else
 if [ "$(wc -c /etc/mail/helpfile | cut -f 1 -d " ")" -eq 0 ]; then
  echo "Size of /etc/mail/helpfile is 0 - meaning it's empty" >> $Results
  echo "Pass" >> $Results
 elif [ "$(egrep -v "^#|^$" /etc/mail/helpfile | wc -l)" -eq 0 ]; then
  echo "Only Commented lines and empty lines found in /etc/mail/helpfile" >> $Results
  echo "Effectively the file is empyt" >> $Results
  echo "Pass" >> $Results
 else
  echo "/etc/mail/helpfile IS NOT EMPTY and CONTAINS LINES NOT COMMENTED OR EMPTY" >> $Results
  ls -l /etc/mail/helpfile >> $Results
  echo "Fail" >> $Results
 fi
fi 
 