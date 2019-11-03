#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library search path environment variable(s) contain a list of directories for the dynamic linker to search to find libraries. If this path includes the current working directory or other relative paths, libraries in these directories may be loaded instead of system libraries. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory.. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22354"
GrpTitle="GEN001605"
RuleID="SV-38343r3_rule"
STIGID="GEN001605"
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

if egrep "LD_LIBRARY_PATH=|SHLIB_PATH=" /sbin/init.d/* | egrep "=:|::|:$|:\." >> $Results; then
 echo "Entries are required to be documented with the ISSM" >> $Results
 echo "Fail" >> $Results
else
 echo "No relative PATHS found in run control scripts" >> $Results
 egrep "LD_LIBRARY_PATH=|SHLIB_PATH=" /sbin/init.d/* >> $Results
 echo "Entries are required to be documented with the ISSM" >> $Results
 echo "Fail" >> $Results
fi