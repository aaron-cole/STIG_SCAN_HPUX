#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If these files are accessible by users other than root or the owner, they could be used by a malicious user to set up a system compromise.

#STIG Identification
GrpID="V-4428"
GrpTitle="GEN002060"
RuleID="SV-34960r1_rule"
STIGID="GEN002060"
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
answerfile="./Results/prestage"

if [ -e "$answerfile" ]; then
 if [ "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")" != "" ]; then
  for file in "$(grep "$GrpID" $answerfile | cut -f 2 -d ":")"; do
   if [ -e "$file" ]; then
    filemode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
    if [ $filemode -eq 700 ] || [ $filemode -eq 600 ] || [ $filemode -eq 400 ]; then
     echo "PASS - $(ls -l $file)" >> $Results
	else
     echo "FAIL - $(ls -l $file)" >> $Results
     ((scorecheck+=1))
    fi
   fi
  done
 else
  echo "No rhost/shosts/host.equiv/shosts.equiv files found" >> $Results
 fi
else
 ((scorecheck+=1))
fi

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi