#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library search path environment variable(s) contains a list of directories for the dynamic linker to search to find libraries. If this path includes the current working directory or other relative paths, libraries in these directories may be loaded instead of system libraries. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22359"
GrpTitle="GEN001845"
RuleID="SV-38348r3_rule"
STIGID="GEN001845"
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
scorecheck=0
chkfiles="/etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login"

for chkfile in $chkfiles; do
 if [ -f $chkfile ]; then
  if egrep "LD_LIBRARY_PATH=|SHLIB_PATH=" "$chkfile" | grep -v "^#" | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
   ((scorecheck+=1))
  else
   echo "No relative PATHS found in $chkfile" >> $Results
  fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi
