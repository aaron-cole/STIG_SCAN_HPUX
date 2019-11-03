#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#The shells file lists approved default shells.  It helps provide layered defense to the security approach by ensuring users cannot change their default shell to an unauthorized, unsecure shell.

#STIG Identification
GrpID="V-917"
GrpTitle="GEN002140"
RuleID="SV-34953r1_rule"
STIGID="GEN002140"
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
validshells="$(cut -f 7 -d ":" /etc/passwd | sort | uniq | egrep -v "^$|/usr/lbin/uucp/uucico|/usr/bin/false|/bin/false|/dev/null|/sbin/nologin")"
scorecheck=0

for shell in $validshells; do
 if grep $shell /etc/shells >> $Results; then
  echo "" >>/dev/null
 else
  echo "$shell doesn't exist in /etc/shells" >> $Results
  ((scorecheck+=1))
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "All shells referenced in /etc/passwd are found in /etc/shells" >> $Results
 echo "Pass" >> $Results
fi