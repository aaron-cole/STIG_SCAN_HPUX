#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#File system extended ACLs provide access to files beyond what is allowed by the mode numbers of the files.

#STIG Identification
GrpID="V-22309"
GrpTitle="GEN000930"
RuleID="SV-38305r1_rule"
STIGID="GEN000930"
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
#File or Directory to check
file="$(grep root /etc/passwd | cut -f 6 -d ":")"

if [ -e $file ]; then
 if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
  echo "Fail" >> $Results
 else
  ls -lLd $file >> $Results
  echo "Pass"  >> $Results
 fi
else
 echo "File does not exist" >> $Results
 echo "Fail" >> $Results
fi