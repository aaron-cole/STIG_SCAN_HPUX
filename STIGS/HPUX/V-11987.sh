#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#A plus (+) in system accounts files causes the system to lookup the specified entry using NIS.  If the system is not using NIS, no such entries should exist.

#STIG Identification
GrpID="V-11987"
GrpTitle="GEN001980"
RuleID="SV-34922r1_rule"
STIGID="GEN001980"
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
