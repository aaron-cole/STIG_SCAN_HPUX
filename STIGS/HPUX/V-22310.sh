#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library search path environment variable(s) contain a list of directories for the dynamic linker to search to find libraries. If this path includes the current working directory or other relative paths, libraries in these directories may be loaded instead of system libraries. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon or two consecutive colons, this is interpreted as the current working directory. Entries starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22310"
GrpTitle="GEN000945"
RuleID="SV-38307r1_rule"
STIGID="GEN000945"
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

checkldlibpath="$(env | grep "^LD_LIBRARY_PATH=")"
checkshlibpath="$(env | grep "^SHLIB_PATH=")"

if [ -z "$checkldlibpath" ]; then
 echo "LD_LIBRARY_PATH is not defined" >> $Results
 if [ -z "$checkshlibpath" ]; then
  echo "SHLIB_PATH is not defined" >> $Results
  echo "Pass" >> $Results
 else
  echo "SHLIB_PATH is defined" >> $Results
  echo "$checkshlibpath" >> $Results
  echo "Fail" >> $Results
 fi
else
 echo "LD_LIBRARY_PATH is defined" >> $Results
 echo "$checkldlibpath" >> $Results
 echo "Fail" >> $Results
fi
 