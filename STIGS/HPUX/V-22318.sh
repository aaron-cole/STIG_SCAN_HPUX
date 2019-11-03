#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#NIS/NIS+/yp files are part of the system's identification and authentication processes and are, therefore, critical to system security. ACLs on these files could result in unauthorized modification, which could compromise these processes and the system. 

#STIG Identification
GrpID="V-22318"
GrpTitle="GEN001361"
RuleID="SV-38284r1_rule"
STIGID="GEN001361"
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
files="/var/yp/*"
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