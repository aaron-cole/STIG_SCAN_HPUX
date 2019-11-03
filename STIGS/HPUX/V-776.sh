#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The executable search path (typically the PATH environment variable) contains a list of directories for the shell to search to find executables. If this path includes the current working directory or other relative paths, executables in these directories may be executed instead of system commands. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory. Entries starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-776"
GrpTitle="GEN000940"
RuleID="SV-38451r3_rule"
STIGID="GEN000940"
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
if env | grep "^PATH=" | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
 echo "Entry requires to be documented with the ISSM" >> $Results
 echo "Fail" >> $Results
else
 echo "No relative PATHS found" >> $Results
 env | grep "^PATH=" >> $Results
 echo "Ensure Entries to be documented with ISSM" >> $Results
 echo "Fail" >> $Results
fi