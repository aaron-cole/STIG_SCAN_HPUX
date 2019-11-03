#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The /etc/shadow file contains the list of local system accounts.  It is vital to system security and must be protected from unauthorized modification.  The file also contains password hashes which must not be accessible to users other than root.

#STIG Identification
GrpID="V-22339"
GrpTitle="GEN001410"
RuleID="SV-38340r2_rule"
STIGID="GEN001410"
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
   GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
   echo "GID for $file is $GOwnerID" >> $Results
   case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "" >> /dev/null;;
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
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  echo "UID for $file is $GOwnerID" >> $Results
  case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "Pass" >> $Results;;
	*) echo "Fail" >> $Results;;
  esac
 else
  echo "$file does not exist" >> $Results
  echo "Pass" >> $Results
 fi
fi