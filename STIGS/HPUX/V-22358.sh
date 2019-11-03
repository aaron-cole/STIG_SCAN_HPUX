#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the skeleton files are not protected, unauthorized personnel could change user startup parameters and possibly jeopardize user files.

#STIG Identification
GrpID="V-22358"
GrpTitle="GEN001830"
RuleID="SV-38347r1_rule"
STIGID="GEN001830"
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
files="/etc/skel/.* /etc/skel/*"
scorecheck=0

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