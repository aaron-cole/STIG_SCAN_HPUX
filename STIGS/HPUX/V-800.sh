#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/shadow file contains the list of local system accounts.  It is vital to system security and must be protected from unauthorized modification.  The file also contains password hashes which must not be accessible to users other than root. The Trusted Mode /tcb tree requires modes more permissive than the shadow file.

#STIG Identification
GrpID="V-800"
GrpTitle="GEN001420"
RuleID="SV-38470r2_rule"
STIGID="GEN001420"
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
file="/etc/shadow"
scorecheck=0

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 file="/tcb"
 filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
 checkmode="555"
 if [ $filemode -le $checkmode ]; then
  echo "$file is $filemode and less than or equal to $checkmode" >> $Results
 else
  echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
  ((scorecheck+=1))  
 fi
 files="/tcb/files /tcb/files/auth"
 for file in $files; do
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="771"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   ((scorecheck+=1))
  fi
 done
 files="/tcb/files/auth/[a-z,A-Z]/*"
 for file in $files; do
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="664"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   ((scorecheck+=1))
  fi
 done
 if [ "$scorecheck" != 0 ]; then
  echo "Fail" >> $Results 
 else 
  echo "Nothing Found" >> $Results
  echo "Pass" >> $Results 
 fi
else
#For SMSE
 if [ -e $file ]; then
  filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  checkmode="400"
  if [ $filemode -le $checkmode ]; then
   echo "$file is $filemode and less than or equal to $checkmode" >> $Results
   echo "Pass" >> $Results
  else
   echo "$file is $filemode and not less than or equal to $checkmode" >> $Results
   echo "Fail" >> $Results
  fi
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi






