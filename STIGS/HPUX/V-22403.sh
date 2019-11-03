#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22403"
GrpTitle="GEN003505"
RuleID="SV-26603r1_rule"
STIGID="GEN003505"
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

if [ "$(coreadm | grep "global core file pattern" | awk -F: '{print $2}')" = " " ]; then
 if [ "$(coreadm | grep "global core dumps" | awk -F: '{print $2}')" = " disabled" ]; then
  coreadm | egrep -i "global core file pattern|global core dumps" >> $Results
  echo "NA" >> $Results
 else
  echo "No core dump directory defined, but core dumps are enabled" >> $Results
  echo "Fail" >> $Results
 fi
else
 coredir="$(coreadm | grep "global core file pattern" | awk -F: '{print $2}')"
 delimitercount="$(echo "$coredir" | tr "/" "\n" | grep -v "^$" | wc -l)"
 filedir="$(echo "$coredir" | cut -f "1-$delimitercount" -d "/")"
 ls -ld $filedir >> $Results
 if ls -lLd $filedir | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  echo "Pass" >> $Results
 fi
fi