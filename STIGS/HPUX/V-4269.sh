#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Accounts providing no operational purpose provide additional opportunities for system compromise. Unnecessary accounts include user accounts for individuals not requiring access to the system and application accounts for applications not installed on the system.

#STIG Identification
GrpID="V-4269"
GrpTitle="GEN000290"
RuleID="SV-38426r1_rule"
STIGID="GEN000290"
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

if egrep "^news:|^games:|^gopher:" /etc/passwd >> $Results; then
 echo "Unecessary Accounts found" >> $Results
 echo "Fail" >> $Results
else
 echo "Review this accounts to make sure they are necessary" >> $Results
 cut -f 1,5 -d ":" /etc/passwd >> $Results
 echo "Fail" >> $Results
fi