#!/bin/sh
##Automatically defined items##

#Vulnerability Discussion
#Changing the root home directory to something other than / and assigning it a 0700 protection makes it more difficult for intruders to manipulate the system by reading the files root places in its default directory. It also gives root the same discretionary access control for root's home directory as for the other plain user home directories.

#STIG Identification
GrpID="V-774"
GrpTitle="GEN000900"
RuleID="SV-34829r1_rule"
STIGID="GEN000900"
Results="./Results/$GrpID"

#Remove File if already there
[ -e $Results ] && rm -rf $Results

#Setup Results File
echo $GrpID >> $Results
echo $GrpTitle >> $Results
echo $RuleID >> $Results
echo $STIGID >> $Results
##END of Automatic Items##

#Checks 
grep "^root" /etc/passwd | cut -f 6 -d ":" >> $Results

if [[ "$(grep "^root" /etc/passwd | cut -f 6 -d ":")" = "/" ]]; then
 echo "Fail"  >> $Results
else
 echo "Pass" >> $Results
fi