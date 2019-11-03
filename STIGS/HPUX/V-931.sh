#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of sensitive files or directories  to root provides the designated owner and possible unauthorized users with the potential to access sensitive information or change system configuration which could weaken the system's security posture.

#STIG Identification
GrpID="V-931"
GrpTitle="GEN005800"
RuleID="SV-35191r3_rule"
STIGID="GEN005800"
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

if [ -e /etc/dfs/sharetab ]; then
 for file in $(cut -f 1 -d " " /etc/dfs/sharetab); do
  if [ -e $file ]; then
   OwnerID="$(perl -le'print((stat shift)[4])' $file)"
   echo "UID for $file is $OwnerID" >> $Results
   case "$OwnerID" in
	0|2|root|bin) echo "" >> /dev/null;;
	*) ((scorecheck+=1));;
   esac
  else
   echo "$file does not exist" >> $Results
  fi
 done
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi