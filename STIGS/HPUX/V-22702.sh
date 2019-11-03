#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Sensitive system and user information could provide a malicious user with enough information to penetrate further into the system.

#STIG Identification
GrpID="V-22702"
GrpTitle="GEN002690"
RuleID="SV-38406r2_rule"
STIGID="GEN002690"
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
files="$(egrep "PRI_AUDFILE|SEC_AUDFILE" /etc/rc.config.d/auditing | grep -v "^#" | cut -f 2 -d "=")"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  GOwnerID="$(perl -le'print((stat shift)[5])' $file)"
  echo "GID for $file is $GOwnerID" >> $Results
  case "$GOwnerID" in
	0|2|3|root|bin|sys) echo "PASS - $(ls -l $file)" >> $Results;;
	*) echo "FAIL - $(ls -l $file)" >> $Results
	   ((scorecheck+=1));;
  esac
  delimitercount="$(echo "$file" | tr "/" "\n" | grep -v "^$" | wc -l)"
  filedir="$(echo "$file" | cut -f "1-$delimitercount" -d "/")"
  GDIROWNER="$(perl -le'print((stat shift)[5])' $filedir)"
  echo "GID for $filedir is $GDIROWNER" >> $Results
  case "$GDIROWNER" in
	0|2|3|root|bin|sys) echo "PASS - $(ls -ld $filedir)" >> $Results;;
	*) echo "FAIL - $(ls -ld $filedir)" >> $Results
	   ((scorecheck+=1));;
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