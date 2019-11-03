#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library preload list environment variable contains a list of libraries for the dynamic linker to load before loading the libraries required by the binary. If this list contains paths to libraries to the current working directory that have not been authorized, unintended libraries may be preloaded. This variable is formatted as a space-separated list of libraries. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22360"
GrpTitle="GEN001850"
RuleID="SV-38349r3_rule"
STIGID="GEN001850"
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
  if grep "LD_PRELOAD=" "$chkfile" | grep -v "^#" | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
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