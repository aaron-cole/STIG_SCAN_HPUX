#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The executable search path (typically the PATH environment variable) contains a list of directories for the shell to search to find executables. If this path includes the current working directory or other relative paths, executables in these directories may be executed instead of system commands. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-11985"
GrpTitle="GEN001840"
RuleID="SV-38270r3_rule"
STIGID="GEN001840"
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
files="/etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/.login "
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  if grep "^PATH=" $file | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
   echo "Fail - $file - Entry requires to be documented with the ISSM" >> $Results
   ((scorecheck+=1))
  else
   grep "^PATH=" $file >> $Results
   echo "Pass - $file - No relative PATHS found" >> $Results
  fi
 else
  echo "Pass - $file does not exist" >> $Results
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi