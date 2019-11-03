#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Process core dumps contain the memory in use by the process when it crashed. Any data the process was handling may be contained in the core file, and it must be protected accordingly. If the process core dump data directory has a mode more permissive than 0700, unauthorized users may be able to view or to modify sensitive information contained any process core dumps in the directory.

#STIG Identification
GrpID="V-22402"
GrpTitle="GEN003504"
RuleID="SV-26598r1_rule"
STIGID="GEN003504"
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
checkmode="700"

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
  filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  if [ $filedirmode -le $checkmode ]; then
   echo "$file is $filedirmode and less than or equal to $checkmode" >> $Results
   echo "Pass" >> $Results
  else
   echo "$file is $filedirmode and not less than or equal to $checkmode" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "$fildir does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi
