#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#

#STIG Identification
GrpID="V-22401"
GrpTitle="GEN003503"
RuleID="SV-26583r1_rule"
STIGID="GEN003503"
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
 if [ -d "$fildir" ]; then
  ls -ld $filedir >> $Results
  GOwnerID="$(perl -le'print((stat shift)[5])' $filedir)"
  echo "UID for $filedir is $GOwnerID" >> $Results
  ls -ld $filedir >> $Results
  case "$GOwnerID" in
   0|2|3|root|bin|sys) echo "Pass" >> $Results;;
   *) echo "Fail" >> $Results
  esac
 else
  echo "$fildir does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi