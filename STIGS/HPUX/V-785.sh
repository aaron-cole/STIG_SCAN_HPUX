#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Unowned files and directories may be unintentionally inherited if a user is assigned the same UID as the UID of the unowned files.

#STIG Identification
GrpID="V-785"
GrpTitle="GEN001160"
RuleID="SV-34833r1_rule"
STIGID="GEN001160"
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
TempResults="$Results-tmp"
find / -nouser >> $TempResults 2>>/dev/null

if [ -s $TempResults ] ; then
  cat $TempResults >> $Results
  echo "Fail" >> $Results
  rm -rf $TempResults
 else
  echo "All files have a valid user" >> $Results
  echo "Pass" >> $Results
  rm -rf $TempResults
fi  