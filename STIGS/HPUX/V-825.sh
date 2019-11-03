#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If the mesg -n or mesg n command is not placed into the system profile, messaging can be used to cause a Denial of Service attack.

#STIG Identification
GrpID="V-825"
GrpTitle="GEN001780"
RuleID="SV-38484r1_rule"
STIGID="GEN001780"
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
files=" /etc/.login /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc"
scorecheck=0

for file in $files; do
 if [ ! -e $file ]; then
  echo "$file does not exist" >> $Results
 else
  if [ "$(grep "mesg -n" $file | grep -v "^#")" ] || [ "$(grep "mesg n" $file | grep -v "^#")" ]; then
   grep "mesg" $file | grep -v "^#" >> $Results
  else
   echo "$file exists and required setting not found" >> $Results
   ((scorecheck+=1))
  fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi