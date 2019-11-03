#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give group-ownership of sensitive files or directories to root provides the members of the owning group with the potential to access sensitive information or change system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-22496"
GrpTitle="GEN005810"
RuleID="SV-35196r2_rule"
STIGID="GEN005810"
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
#File or Directory to check
scorecheck=0

if [ -e /etc/dfs/sharetab ] && [ -n /etc/dfs/sharetab ]; then
 files="$(cat /etc/dfs/sharetab | tr '\011' ' ' | tr -s ' ' | sed -e 's/^[ \t]*//' | cut -f 1,1 -d " ")"
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
else
 echo "/etc/dfs/sharetab does not exist or is empty"  >> $Results
 echo "Pass" >> $Results
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi