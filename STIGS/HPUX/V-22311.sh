#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The library preload list environment variable contains a list of libraries for the dynamic linker to load before loading the libraries required by the binary.  If this list contains paths to libraries relative to the current working directory, unintended libraries may be preloaded.  This variable is formatted as a space-separated list of libraries.  Paths starting with (/) are absolute paths.

#STIG Identification
GrpID="V-22311"
GrpTitle="GEN000950"
RuleID="SV-38308r1_rule"
STIGID="GEN000950"
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

checkldpreloadpath="$(env | grep "^LD_PRELOAD=")"


if [ -z "$checkldpreloadpath" ]; then
 echo "LD_PRELOAD is not defined" >> $Results
 echo "Pass" >> $Results
else
 echo "LD_PRELOAD is defined" >> $Results
 echo "$checkldpreloadpath" >> $Remove
 echo "Fail" >> $Results
fi