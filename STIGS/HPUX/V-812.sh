#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Failure to give ownership of system audit log files to root provides the designated owner and unauthorized users with the potential to access sensitive information.

#STIG Identification
GrpID="V-812"
GrpTitle="GEN002680"
RuleID="SV-38477r2_rule"
STIGID="GEN002680"
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
  OwnerID="$(perl -le'print((stat shift)[4])' $file)"
  echo "UID for $file is $OwnerID" >> $Results
  case "$OwnerID" in
	0|root) echo "PASS - $(ls -l $file)" >> $Results;;
	*) echo "FAIL - $(ls -l $file)" >> $Results
	   ((scorecheck+=1));;
  esac
  delimitercount="$(echo "$file" | tr "/" "\n" | grep -v "^$" | wc -l)"
  filedir="$(echo "$file" | cut -f "1-$delimitercount" -d "/")"
  DIROWNER="$(perl -le'print((stat shift)[4])' $filedir)"
  echo "UID for $filedir is $DIROWNER" >> $Results
  case "$DIROWNER" in
	0|root) echo "PASS - $(ls -ld $filedir)" >> $Results;;
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