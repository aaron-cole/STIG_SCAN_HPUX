#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To prevent unauthorized access or manipulation of system audit logs, the tools for manipulating those logs must be protected.

#STIG Identification
GrpID="V-22373"
GrpTitle="GEN002718"
RuleID="SV-26516r2_rule"
STIGID="GEN002718"
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

for file in /usr/sbin/aud* /usr/sbin/userdb*; do
 if [ -f "$file" ] ;then
  if ls -lLd $file | awk '{print $1}' | grep "+" >> $Results; then
   echo "FAIL - $file has an ACL" >> $Results
   ((scorecheck+=1))
  else
   echo "PASS - $file DOES NOT HAVE an ACL" >> $Results
  fi
 fi
done
  
if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi