#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If users do not have a valid home directory, there is no place for the storage and control of files they own.

#STIG Identification
GrpID="V-899"
GrpTitle="GEN001440"
RuleID="SV-38488r2_rule"
STIGID="GEN001440"
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

if pwck >> $Results 2>>$Results ; then
 if pwck | grep -i "Login directory null" >> /dev/null; then
  echo "A User is not assigned a home directory" >> $Results
  echo "Fail" >> $Results
 else
  echo "All Users are assigned a home directory" >> $Results
  echo "Pass" >> $Results
 fi
else
 echo "All Users are assigned a home directory" >> $Results
 echo "Pass" >> $Results
fi