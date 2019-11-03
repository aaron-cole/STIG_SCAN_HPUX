#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/shadow file contains the list of local system accounts.  It is vital to system security and must be protected from unauthorized modification.  The file also contains password hashes which must not be accessible to users other than root.

#STIG Identification
GrpID="V-22340"
GrpTitle="GEN001430"
RuleID="SV-26441r2_rule"
STIGID="GEN001430"
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

#For Trusted Mode
if [ -f /tcb/files/auth/system/default ]; then
 files="/tcb /tcb/files /tcb/files/auth /tcb/files/auth/[a-z,A-Z]/*"
 for file in $files; do
  if [ -e $file ]; then
   if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
    ((scorecheck+=1))
   fi
  else
   echo "$file does not exist" >> $Results
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
 file="/etc/shadow"
 if [ -e $file ]; then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   echo "Fail" >> $Results
  else
   echo "Pass"  >> $Results
  fi
 else
  echo "$file does not exist" >> $Results
  echo "Fail" >> $Results
 fi
fi