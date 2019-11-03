#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If successful and unsuccessful logins and logouts are not monitored or recorded, access attempts cannot be tracked.  Without this logging, it may be impossible to track unauthorized access to the system.

#STIG Identification
GrpID="V-11980"
GrpTitle="GEN001060"
RuleID="SV-38248r2_rule"
STIGID="GEN001060"
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

if [ -e /var/adm/sulog ]; then
 if grep "\-root" /var/adm/sulog >> $Results; then
  echo "SU to root is being logged" >> $Results
  echo "Pass" >> $Results
 else
  { echo "exit"; } | sudo su - >> /dev/null 2>>/dev/null
  if grep "\-root" /var/adm/sulog >> $Results; then
   echo "SU to root is being logged" >> $Results
   echo "Pass" >> $Results
  else
   echo "SU to root do not appear to be logged" >> $Results
   echo "Fail" >> $Results
  fi
 fi
else
 echo "/var/adm/sulog does not exist" >> $Results
 echo "Please check the location of where the su logs are kept" >> $Results
 echo "Fail" >> $Results
fi