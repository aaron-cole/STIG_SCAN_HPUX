#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The executable search path (typically the PATH environment variable) contains a list of directories for the shell to search to find executables. If this path includes the current working directory or other relative paths, executables in these directories may be executed instead of system commands. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory. Paths starting with a slash (/) are absolute paths. 

#STIG Identification
GrpID="V-907"
GrpTitle="GEN001600"
RuleID="SV-38495r3_rule"
STIGID="GEN001600"
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
if grep "PATH=" /sbin/init.d/* | grep -v "_PATH" | egrep "=:|::|:$|:\." >> $Results; then
 echo "Entry requires to be documented with the ISSM" >> $Results
 echo "Fail" >> $Results
else
 echo "No relative PATHS found" >> $Results
 echo "Pass" >> $Results
fi