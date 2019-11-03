#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#If a user is assigned the GID of a group not existing on the system, and a group with that GID is subsequently created, the user may have unintended rights to the group.

#STIG Identification
GrpID="V-781"
GrpTitle="GEN000380"
RuleID="SV-38455r1_rule"
STIGID="GEN000380"
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

for f in $(cut -f 4 -d ":" /etc/passwd | sort | uniq); do
 if grep ":$f:" /etc/group >> /dev/null; then
  echo "" >> /dev/null
 else
  ((scorecheck+=1))  
  echo "$f - Not Defined in /etc/group" >> $Results
 fi  
done

if [ "$scorecheck" != 0 ]
then
 echo "Fail" >> $Results 
else 
 echo "Nothing Found" >> $Results 
 echo "Pass" >> $Results
fi