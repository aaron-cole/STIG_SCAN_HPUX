#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Excessive permissions allow unauthorized access to user files.

#STIG Identification
GrpID="V-22352"
GrpTitle="GEN001570"
RuleID="SV-38325r1_rule"
STIGID="GEN001570"
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
checkfiles="$(logins -x -u -o | cut -f 6 -d ":" | sort | uniq)"

for homedir in $checkfiles; do
 if [ -d "$homedir" ]; then
  if ls -alLR $homedir | grep '^[a-zA-Z\-]\{10\}+' >> $Results; then
   ((scorecheck+=1))
  else
   echo "PASS - $homedir" >> $Results
  fi
 fi
done

if [ "$scorecheck" != 0 ]; then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results
 echo "Pass" >> $Results
fi