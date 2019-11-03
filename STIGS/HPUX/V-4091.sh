#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#System start-up files that execute programs owned by other than root (or another privileged user) or an application indicate that the system may have been compromised.

#STIG Identification
GrpID="V-4091"
GrpTitle="GEN001700"
RuleID="SV-38422r1_rule"
STIGID="GEN001700"
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
#files="/sbin/init.d/*"
#scorecheck=0

#for file in $files; do
# if [ -e $file ]; then
#  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
#  echo "UID for $file is $OwnerID" >> $Results
#  case "$OwnerID" in
#	0|2|3|root|bin|sys) echo "" >> /dev/null;;
#	*) ((scorecheck+=1));;
#  esac
# else
#  echo "$file does not exist" >> $Results
# fi
#done

#if [ "$scorecheck" != 0 ]; then
# echo "Fail" >> $Results 
#else 
# echo "Nothing Found" >> $Results
# echo "Pass" >> $Results
#fi

echo "Manual Review" >> $Results
echo "Fail" >> $Results
