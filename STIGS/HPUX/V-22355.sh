#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library preload list environment variable contains a list of libraries for the dynamic linker to load before loading the libraries required by the binary. If this list contains paths to libraries to the current working directory that have not been authorized, unintended libraries may be preloaded. This variable is formatted as a space-separated list of libraries. Paths starting with a slash (/) are absolute paths.

#STIG Identification
GrpID="V-22355"
GrpTitle="GEN001610"
RuleID="SV-38344r3_rule"
STIGID="GEN001610"
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

if grep "LD_PRELOAD=" /sbin/init.d/* | grep -v "^#" | egrep "=:|::|:$|:\." >> $Results; then
 echo "Entries are required to be documented with the ISSM" >> $Results
 echo "Fail" >> $Results
elif [ -z "$(grep "LD_PRELOAD=" /sbin/init.d/* | grep -v "^#")" ]; then
 echo "No LD_PRELOAD variable definitions found" >> $Results
 echo "Pass" >> $Results
else
 echo "No relative PATHS found in run control scripts" >> $Results
 grep "LD_PRELOAD=" /sbin/init.d/* >> $Results
 echo "Fail" >> $Results
fi