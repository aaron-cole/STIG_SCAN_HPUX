#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library preload list environment variable contains a list of libraries for the dynamic linker to load before loading the libraries required by the binary. If this list contains paths to libraries to the current working directory that have not been authorized, unintended libraries may be preloaded. This variable is formatted as a space-separated list of libraries. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22364"
GrpTitle="GEN001902"
RuleID="SV-34928r3_rule"
STIGID="GEN001902"
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
   if grep "LD_PRELOAD=" "$HOMEDIR/$initfile" | grep -v "^#" | egrep "=:|::|:$|:\.|:[a-zA-Z0-9]" >> $Results; then
    ((scorecheck+=1))
   elif grep "LD_PRELOAD=" "$HOMEDIR/$initfile" | grep -v "^#" >> $Results; then
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