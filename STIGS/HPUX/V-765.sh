#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Monitoring and recording successful and unsuccessful logins assists in tracking unauthorized access to the system.  Without this logging, the ability to track unauthorized activity to specific user accounts may be diminished.

#STIG Identification
GrpID="V-765"
GrpTitle="GEN000440"
RuleID="SV-27082r1_rule"
STIGID="GEN000440"
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

lastsucclogins="$(last -R)"
lastunsucclogins="$(lastb -R)"

if [ "$(echo "$lastsucclogins" | wc -l)" -gt 4 ]; then
 echo "--Successful logins are being logged" >> $Results
 echo "--This is the top 20 lines" >> $Results
 last -R -20 >> $Results
 if [ "$(echo "$lastunsucclogins" | wc -l)" -gt 4 ]; then
  echo "--Unsuccessful logins are being logged" >> $Results
  echo "--This is the top 20 lines" >> $Results
  lastb -R -20 >> $Results
  echo "" >> $Results
  echo "Pass" >> $Results
 else
  echo "--Unsuccessful logins are NOT being logged" >> $Results
  echo "" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "--Successful logins are NOT being logged" >> $Results
 echo "" >> $Results
 echo "Fail" >> $Results
fi
