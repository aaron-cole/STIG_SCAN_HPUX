#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library search path environment variable(s) contain a list of directories for the dynamic linker to search to find libraries. If this path includes the current working directory or other relative paths, libraries in these directories may be loaded instead of system libraries. This variable is formatted as a colon-separated list of directories. If there is an empty entry, such as a leading or trailing colon, two consecutive colons, or a single period, this is interpreted as the current working directory. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22363"
GrpTitle="GEN001901"
RuleID="SV-38351r3_rule"
STIGID="GEN001901"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
scorecheck=0
initfiles=".login .bash_profile .bashrc .bash_logout .cshrc .profile .tcshrc .kshrc .logout .env .dtprofile .dispatch .emacs .exrc"

for HOMEDIR in $(logins -o -x | awk -F: '{print $6}'); do
 for initfile in $initfiles; do 
  if [ -f $HOMEDIR/$initfile ]; then
   if egrep "LD_LIBRARY_PATH=|SHLIB_PATH=" "$HOMEDIR/$initfile" | grep -v "^#" | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
    ((scorecheck+=1))
   elif egrep "LD_LIBRARY_PATH=|SHLIB_PATH=" "$HOMEDIR/$initfile" | grep -v "^#" >> $Results; then
    ((scorecheck+=1))
   else
    echo "No PATHS found in $chkfile" >> $Results
   fi
  fi
 done
done

if [ "$scorecheck" != 0 ]; then
 echo "These must be Documented with the ISSO" >> $Results
 echo "Fail" >> $Results 
else 
 echo "Nothing Found with ACLs" >> $Results
 echo "Pass" >> $Results
fi
