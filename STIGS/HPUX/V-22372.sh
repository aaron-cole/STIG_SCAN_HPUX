#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#To prevent unauthorized access or manipulation of system audit logs, the tools for manipulating those logs must be protected.

#STIG Identification
GrpID="V-22372"
GrpTitle="GEN002717"
RuleID="SV-26512r2_rule"
STIGID="GEN002717"
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
checkmode="750"

for file in /usr/sbin/aud* /usr/sbin/userdb*; do
 if [ -f "$file" ] ;then
  filedirmode="$(perl -le'printf "%o\n",(stat shift)[2] & 07777' $file)"
  if [ $filedirmode -le $checkmode ]; then
   echo "$file is $filedirmode and less than or equal to $checkmode" >> $Results
  else
   echo "$file is $filedirmode and not less than or equal to $checkmode" >> $Results
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
