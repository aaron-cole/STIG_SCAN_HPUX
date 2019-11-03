#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Global initialization files are used to configure the user's shell environment upon login.  Malicious modification of these files could compromise accounts upon logon.

#STIG Identification
GrpID="V-22356"
GrpTitle="GEN001730"
RuleID="SV-38345r1_rule"
STIGID="GEN001730"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

###Check###
#File or Directory to check
files="/etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ"
scorecheck=0

for file in $files; do
 if [ -e $file ]; then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   ((scorecheck+=1))
  fi
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