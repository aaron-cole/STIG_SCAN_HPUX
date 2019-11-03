#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Specifying a centralized location for core file creation allows for the centralized protection of core files. Process core dumps contain the memory in use by the process when it crashed. Any data the process was handling may be contained in the core file, and it must be protected accordingly. If process core dump creation is not configured to use a centralized directory, core dumps may be created in a directory without appropriate ownership or permissions configured, which could result in unauthorized access to the core dumps.

#STIG Identification
GrpID="V-22399"
GrpTitle="GEN003501"
RuleID="SV-26577r1_rule"
STIGID="GEN003501"
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
 coredir="$(coreadm | grep "global core file pattern" | awk -F: '{print $2}' | cut -c 2-)"
 coredirfirstchar="$(echo "$coredir" | cut -c 1)"
 echo "$(coreadm | grep "global core file pattern")" >> $Results
 if [ "$coredirfirstchar" = "/" ]; then
  echo "File dump directory is NOT relative" >> $Results
  echo "Pass" >> $Results
 else
  echo "File dump directory IS relative" >> $Results
  echo "Fail" >> $Results
 fi
fi