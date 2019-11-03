#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/shadow file contains the list of local system accounts.  It is vital to system security and must be protected from unauthorized modification.  Failure to give ownership of sensitive files or utilities to root or bin provides the designated owner and unauthorized users with the potential to access sensitive information or change the system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-797"
GrpTitle="GEN001400"
RuleID="SV-38468r2_rule"
STIGID="GEN001400"
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
 files="/etc/shadow /tcb /tcb/files /tcb/files/auth /tcb/files/auth/[a-z,A-Z]/*"
 for file in $files; do
  if [ -e $file ]; then
   OwnerID="$(perl -le'print((stat shift)[4])' $file)"
   echo "UID for $file is $OwnerID" >> $Results
   case "$OwnerID" in
	0|root) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
   esac
  else
   echo "$file does not exist" >> $Results
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
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|root) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
  esac
 else
  echo "$file does not exist" >> $Results
  echo "Pass" >> $Results
 fi
fi