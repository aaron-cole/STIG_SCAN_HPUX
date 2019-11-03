#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The .rhosts, .shosts, hosts.equiv, and shosts.equiv files are used to configure host-based authentication for individual users or the system.  Host-based authentication is not sufficient for preventing unauthorized access to the system.

#STIG Identification
GrpID="V-11988"
GrpTitle="GEN002040"
RuleID="SV-38249r1_rule"
STIGID="GEN002040"
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
answerfile="./Results/prestage"

if [ -e "$answerfile" ]; then
 if [ "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")" != "" ]; then
  echo "rhost/shosts/host.equiv/shosts.equiv files found" >> $Results
  grep "$GrpID" $answerfile | cut -f 2 -d ":" >> $Results
  echo "Fail" >> $Results
 else
  echo "No rhost/shosts/host.equiv/shosts.equiv files found" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "Fail" >> $Results
fi